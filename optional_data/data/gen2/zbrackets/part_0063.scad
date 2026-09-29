$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 60 x 40 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
foot_len = 60;            // lower foot length, X
top_len = 35;             // upper foot length, X
depth = 40;               // bracket width, Y
step_h = 50;              // overall rise, Z
plate_t = 4;              // plate thickness
hole_d = 9;               // clearance for M8

module hole_z(px, py, z0) {
  translate([px, py, z0 - 0.5]) cylinder(h = plate_t + 1, d = hole_d);
}
module hole_x(py, pz) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = plate_t + 1, d = hole_d);
}

difference() {
  union() {
    cube([foot_len, depth, plate_t]);
    /* web, overlapping the lower foot */
    translate([foot_len - plate_t, 0, 0]) cube([plate_t, depth, step_h]);
    /* upper foot, sunk into the web */
    translate([foot_len - plate_t - top_len, 0, step_h - plate_t]) cube([top_len + plate_t, depth, plate_t]);
  }
  hole_z(18, 20, 0);
  translate([foot_len - plate_t - 17, 0, 0]) hole_z(0, 20, step_h - plate_t);
  translate([foot_len - plate_t, 0, 0]) hole_x(20, 18);
}
