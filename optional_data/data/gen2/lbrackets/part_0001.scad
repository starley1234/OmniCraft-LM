$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 65 x 32 x 55 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
horiz_len = 65;           // horizontal leg, X
vert_len = 55;            // vertical leg, Z
profile_w = 32;           // bracket depth, Y
plate_t = 3.5;            // plate thickness
hole_d = 6.6;             // clearance for M6

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
  hole_z(13.2, 16);
  hole_z(51.8, 16);
  hole_x(13.2, 16);
  hole_x(41.8, 16);
}
