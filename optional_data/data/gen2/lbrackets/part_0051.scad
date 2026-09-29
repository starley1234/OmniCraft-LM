$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 30 x 16 x 30 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
horiz_len = 30;           // horizontal leg, X
vert_len = 30;            // vertical leg, Z
profile_w = 16;           // bracket depth, Y
plate_t = 3;              // plate thickness
hole_d = 3.4;             // clearance for M3

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = plate_t + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = plate_t + 5, d = hole_d);
}

difference() {
  union() {
    /* horizontal leg */
    cube([horiz_len, profile_w, plate_t]);
    /* vertical leg, overlapping the corner block */
    cube([plate_t, profile_w, vert_len]);
  }
  hole_z(6.8, 8);
  hole_z(23.2, 8);
  hole_x(6.8, 8);
  hole_x(23.2, 8);
}
