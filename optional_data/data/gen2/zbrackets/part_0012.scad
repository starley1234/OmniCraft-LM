$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 45 x 35 x 35 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bottom_run = 45;          // lower foot length, X
top_run = 35;             // upper foot length, X
profile_w = 35;           // bracket width, Y
height = 35;              // overall rise, Z
mat_t = 3;                // plate thickness
hole_d = 6.6;             // clearance for M6

module hole_z(px, py, z0) {
  translate([px, py, z0 - 0.5]) cylinder(h = mat_t + 1, d = hole_d);
}
module hole_x(py, pz) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = mat_t + 1, d = hole_d);
}

difference() {
  union() {
    cube([bottom_run, profile_w, mat_t]);
    /* web, overlapping the lower foot */
    translate([bottom_run - mat_t, 0, 0]) cube([mat_t, profile_w, height]);
    /* upper foot, sunk into the web */
    translate([bottom_run - mat_t - top_run, 0, height - mat_t]) cube([top_run + mat_t, profile_w, mat_t]);
  }
  hole_z(13.2, 17.5, 0);
  translate([bottom_run - mat_t - 21, 0, 0]) hole_z(0, 17.5, height - mat_t);
  translate([bottom_run - mat_t, 0, 0]) hole_x(17.5, 13.2);
}
