$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 70 x 25 x 45 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bottom_run = 70;          // lower foot length, X
top_run = 30;             // upper foot length, X
profile_w = 25;           // bracket width, Y
height = 45;              // overall rise, Z
mat_t = 5;                // plate thickness
hole_d = 4.5;             // clearance for M4
cb_d = 8;                 // counterbore diameter
cb_h = 2.4;               // counterbore depth
rib_len = 18;             // gusset leg
rib_sink = 1.6;           // gusset overlap into the plates

module hole_z(px, py, z0) {
  translate([px, py, z0 - 2.5]) cylinder(h = mat_t + 5, d = hole_d);
}
module hole_x(py, pz) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = mat_t + 5, d = hole_d);
}
module cb_z(px, py, top_z) {
  translate([px, py, top_z - cb_h]) cylinder(h = cb_h + 0.5, d = cb_d);
}
module cb_x(py, pz) {
  translate([mat_t - cb_h, py, pz]) rotate([0, -90, 0]) cylinder(h = cb_h + 0.5, d = cb_d);
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
  hole_z(9, 12.5, 0);
  translate([bottom_run - mat_t - 18, 0, 0]) hole_z(0, 12.5, height - mat_t);
  translate([bottom_run - mat_t, 0, 0]) hole_x(12.5, 29.45);
  cb_z(9, 12.5, mat_t);
  translate([bottom_run - mat_t - 18, 0, 0]) cb_z(0, 12.5, height);
  translate([bottom_run - mat_t, 0, 0]) cb_x(12.5, 29.45);
}
