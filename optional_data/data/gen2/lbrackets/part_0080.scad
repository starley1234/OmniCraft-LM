$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 40 x 32 x 35 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
horiz_len = 40;           // horizontal leg, X
vert_len = 35;            // vertical leg, Z
profile_w = 32;           // bracket depth, Y
plate_t = 4.5;            // plate thickness
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
  hole_z(9, 16);
  hole_z(31, 16);
  hole_x(9, 16);
  hole_x(26, 16);
}
