$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 70 x 40 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
foot_len = 70;            // lower foot length, X
top_len = 25;             // upper foot length, X
depth = 40;               // bracket width, Y
step_h = 60;              // overall rise, Z
plate_t = 5;              // plate thickness
hole_d = 4.5;             // clearance for M4
cb_d = 8;                 // counterbore diameter
cb_h = 2.4;               // counterbore depth

module hole_z(px, py, z0) {
  translate([px, py, z0 - 0.5]) cylinder(h = plate_t + 1, d = hole_d);
}
module hole_x(py, pz) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = plate_t + 1, d = hole_d);
}
module cb_z(px, py, top_z) {
  translate([px, py, top_z - cb_h]) cylinder(h = cb_h + 0.5, d = cb_d);
}
module cb_x(py, pz) {
  translate([plate_t - cb_h, py, pz]) rotate([0, -90, 0]) cylinder(h = cb_h + 0.5, d = cb_d);
}

difference() {
  union() {
    cube([foot_len, depth, plate_t]);
    /* web, overlapping the lower foot */
    translate([foot_len - plate_t, 0, 0]) cube([plate_t, depth, step_h]);
    /* upper foot, sunk into the web */
    translate([foot_len - plate_t - top_len, 0, step_h - plate_t]) cube([top_len + plate_t, depth, plate_t]);
  }
  hole_z(9, 20, 0);
  translate([foot_len - plate_t - 15, 0, 0]) hole_z(0, 20, step_h - plate_t);
  translate([foot_len - plate_t, 0, 0]) hole_x(20, 9);
  cb_z(9, 20, plate_t);
  translate([foot_len - plate_t - 15, 0, 0]) cb_z(0, 20, step_h);
  translate([foot_len - plate_t, 0, 0]) cb_x(20, 9);
}
