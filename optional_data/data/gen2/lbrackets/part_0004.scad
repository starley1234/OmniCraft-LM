$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 80 x 24 x 30 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
horiz_len = 80;           // horizontal leg, X
vert_len = 30;            // vertical leg, Z
profile_w = 24;           // bracket depth, Y
plate_t = 4;              // plate thickness
hole_d = 5.5;             // clearance for M5

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
  hole_z(40, 12);
  hole_x(15, 12);
}
