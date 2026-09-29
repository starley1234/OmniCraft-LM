$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 45 x 35 x 45 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
foot_len = 45;            // lower foot length, X
top_len = 35;             // upper foot length, X
depth = 35;               // bracket width, Y
step_h = 45;              // overall rise, Z
plate_t = 5;              // plate thickness
hole_d = 4.5;             // clearance for M4

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
  hole_z(9, 17.5, 0);
  translate([foot_len - plate_t - 21, 0, 0]) hole_z(0, 17.5, step_h - plate_t);
  translate([foot_len - plate_t, 0, 0]) hole_x(17.5, 9);
}
