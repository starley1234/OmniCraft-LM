$fn = 32;
// ----------------------------------------------------------------------
// Z-bracket: 55 x 40 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bottom_run = 55;          // lower foot length, X
top_run = 43;             // upper foot length, X
profile_w = 40;           // bracket width, Y
height = 40;              // overall rise, Z
mat_t = 6;                // plate thickness
hole_d = 5.5;             // clearance for M5

module hole_z(px, py, z0) {
  translate([px, py, z0 - 2.5]) cylinder(h = mat_t + 5, d = hole_d);
}
module hole_x(py, pz) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = mat_t + 5, d = hole_d);
}

difference() {
  union() {
    cube([bottom_run, profile_w, mat_t]);
    /* web, overlapping the lower foot */
    translate([bottom_run - mat_t, 0, 0]) cube([mat_t, profile_w, height]);
    /* upper foot, sunk into the web */
    translate([bottom_run - mat_t - top_run, 0, height - mat_t]) cube([top_run + mat_t, profile_w, mat_t]);
  }
  hole_z(11, 20, 0);
  translate([bottom_run - mat_t - 25.8, 0, 0]) hole_z(0, 20, height - mat_t);
  translate([bottom_run - mat_t, 0, 0]) hole_x(20, 20);
}
