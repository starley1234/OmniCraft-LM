$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 80 x 40 x 35 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
foot_len = 80;            // lower foot length, X
top_len = 30;             // upper foot length, X
depth = 40;               // bracket width, Y
step_h = 35;              // overall rise, Z
plate_t = 4;              // plate thickness
hole_d = 5.5;             // clearance for M5

module hole_z(px, py, z0) {
  translate([px, py, z0 - 2.5]) cylinder(h = plate_t + 5, d = hole_d);
}
module hole_x(py, pz) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = plate_t + 5, d = hole_d);
}

difference() {
  union() {
    cube([foot_len, depth, plate_t]);
    /* web, overlapping the lower foot */
    translate([foot_len - plate_t, 0, 0]) cube([plate_t, depth, step_h]);
    /* upper foot, sunk into the web */
    translate([foot_len - plate_t - top_len, 0, step_h - plate_t]) cube([top_len + plate_t, depth, plate_t]);
  }
  hole_z(11, 20, 0);
  translate([foot_len - plate_t - 18, 0, 0]) hole_z(0, 20, step_h - plate_t);
  translate([foot_len - plate_t, 0, 0]) hole_x(20, 17.5);
}
