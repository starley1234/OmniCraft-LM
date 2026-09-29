$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 70 x 35 x 30 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bottom_run = 70;          // lower foot length, X
top_run = 45;             // upper foot length, X
profile_w = 35;           // bracket width, Y
height = 30;              // overall rise, Z
mat_t = 3;                // plate thickness
hole_d = 5.5;             // clearance for M5
rib_len = 13.2;           // gusset leg
rib_sink = 0.9;           // gusset overlap into the plates

module hole_z(px, py, z0) {
  translate([px, py, z0 - 0.5]) cylinder(h = mat_t + 1, d = hole_d);
}
module hole_x(py, pz) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = mat_t + 1, d = hole_d);
}
module gusset(x0) {
  translate([x0, profile_w - rib_sink, 0])
    rotate([90, 0, 0])
      linear_extrude(height = profile_w - 2 * rib_sink)
        polygon(points = [[rib_sink, mat_t - rib_sink],
                          [rib_sink, mat_t - rib_sink + rib_len],
                          [-rib_len, mat_t - rib_sink]]);
}

difference() {
  union() {
    cube([bottom_run, profile_w, mat_t]);
    /* web, overlapping the lower foot */
    translate([bottom_run - mat_t, 0, 0]) cube([mat_t, profile_w, height]);
    /* upper foot, sunk into the web */
    translate([bottom_run - mat_t - top_run, 0, height - mat_t]) cube([top_run + mat_t, profile_w, mat_t]);
    gusset(bottom_run - mat_t);
  }
  hole_z(11, 17.5, 0);
  translate([bottom_run - mat_t - 27, 0, 0]) hole_z(0, 17.5, height - mat_t);
  translate([bottom_run - mat_t, 0, 0]) hole_x(17.5, 11);
}
