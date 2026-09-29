$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 55 x 30 x 45 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
foot_len = 55;            // lower foot length, X
top_len = 40;             // upper foot length, X
depth = 30;               // bracket width, Y
step_h = 45;              // overall rise, Z
plate_t = 6;              // plate thickness
hole_d = 3.4;             // clearance for M3
cb_d = 6;                 // counterbore diameter
cb_h = 1.9;               // counterbore depth

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
  hole_z(6.8, 15, 0);
  translate([foot_len - plate_t - 24, 0, 0]) hole_z(0, 15, step_h - plate_t);
  translate([foot_len - plate_t, 0, 0]) hole_x(15, 6.8);
  cb_z(6.8, 15, plate_t);
  translate([foot_len - plate_t - 24, 0, 0]) cb_z(0, 15, step_h);
  translate([foot_len - plate_t, 0, 0]) cb_x(15, 6.8);
}
