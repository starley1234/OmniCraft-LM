$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 40 x 25 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
foot_len = 40;            // lower foot length, X
top_len = 28;             // upper foot length, X
depth = 25;               // bracket width, Y
step_h = 25;              // overall rise, Z
plate_t = 6;              // plate thickness
hole_d = 3.4;             // clearance for M3
cb_d = 6;                 // counterbore diameter
cb_h = 1.9;               // counterbore depth

module hole_z(px, py, z0) {
  translate([px, py, z0 - 2.5]) cylinder(h = plate_t + 5, d = hole_d);
}
module hole_x(py, pz) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = plate_t + 5, d = hole_d);
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
  hole_z(6.8, 12.5, 0);
  translate([foot_len - plate_t - 16.8, 0, 0]) hole_z(0, 12.5, step_h - plate_t);
  translate([foot_len - plate_t, 0, 0]) hole_x(12.5, 12.5);
  cb_z(6.8, 12.5, plate_t);
  translate([foot_len - plate_t - 16.8, 0, 0]) cb_z(0, 12.5, step_h);
  translate([foot_len - plate_t, 0, 0]) cb_x(12.5, 12.5);
}
