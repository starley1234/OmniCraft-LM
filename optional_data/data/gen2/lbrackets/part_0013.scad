$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 55 x 30 x 30 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
horiz_len = 55;           // horizontal leg, X
vert_len = 30;            // vertical leg, Z
profile_w = 30;           // bracket depth, Y
plate_t = 4;              // plate thickness
hole_d = 4.5;             // clearance for M4

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = plate_t + 1, d = hole_d);
}
module hole_x(pz, py) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = plate_t + 1, d = hole_d);
}

difference() {
  union() {
    /* horizontal leg */
    cube([horiz_len, profile_w, plate_t]);
    /* vertical leg, overlapping the corner block */
    cube([plate_t, profile_w, vert_len]);
  }
  hole_z(9, 15);
  hole_z(46, 15);
  hole_x(9, 15);
  hole_x(21, 15);
}
