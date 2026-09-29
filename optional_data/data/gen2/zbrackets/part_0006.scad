$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 50 x 50 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bottom_run = 50;          // lower foot length, X
top_run = 30;             // upper foot length, X
profile_w = 50;           // bracket width, Y
height = 50;              // overall rise, Z
mat_t = 6;                // plate thickness
hole_d = 5.5;             // clearance for M5
cb_d = 9.5;               // counterbore diameter
cb_h = 2.9;               // counterbore depth

module hole_z(px, py, z0) {
  translate([px, py, z0 - 0.5]) cylinder(h = mat_t + 1, d = hole_d);
}
module hole_x(py, pz) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = mat_t + 1, d = hole_d);
}
module cb_z(px, py, top_z) {
  translate([px, py, top_z - cb_h]) cylinder(h = cb_h + 0.5, d = cb_d);
}
module cb_x(py, pz) {
  translate([mat_t - cb_h, py, pz]) rotate([0, -90, 0]) cylinder(h = cb_h + 0.5, d = cb_d);
}

difference() {
  union() {
    cube([bottom_run, profile_w, mat_t]);
    /* web, overlapping the lower foot */
    translate([bottom_run - mat_t, 0, 0]) cube([mat_t, profile_w, height]);
    /* upper foot, sunk into the web */
    translate([bottom_run - mat_t - top_run, 0, height - mat_t]) cube([top_run + mat_t, profile_w, mat_t]);
  }
  hole_z(11, 25, 0);
  translate([bottom_run - mat_t - 18, 0, 0]) hole_z(0, 25, height - mat_t);
  translate([bottom_run - mat_t, 0, 0]) hole_x(25, 11);
  cb_z(11, 25, mat_t);
  translate([bottom_run - mat_t - 18, 0, 0]) cb_z(0, 25, height);
  translate([bottom_run - mat_t, 0, 0]) cb_x(25, 11);
}
