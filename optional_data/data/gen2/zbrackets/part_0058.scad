$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 60 x 20 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
foot_len = 60;            // lower foot length, X
top_len = 40;             // upper foot length, X
depth = 20;               // bracket width, Y
step_h = 40;              // overall rise, Z
plate_t = 4;              // plate thickness
hole_d = 4.5;             // clearance for M4

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
  hole_z(9, 10, 0);
  translate([foot_len - plate_t - 24, 0, 0]) hole_z(0, 10, step_h - plate_t);
  translate([foot_len - plate_t, 0, 0]) hole_x(10, 20);
}
