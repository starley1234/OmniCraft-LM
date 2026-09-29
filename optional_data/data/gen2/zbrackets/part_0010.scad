$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 55 x 20 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bottom_run = 55;          // lower foot length, X
top_run = 35;             // upper foot length, X
profile_w = 20;           // bracket width, Y
height = 60;              // overall rise, Z
mat_t = 5;                // plate thickness
hole_d = 4.5;             // clearance for M4

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
  hole_z(9, 10, 0);
  translate([bottom_run - mat_t - 21, 0, 0]) hole_z(0, 10, height - mat_t);
  translate([bottom_run - mat_t, 0, 0]) hole_x(10, 30);
}
