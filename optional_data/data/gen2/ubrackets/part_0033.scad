$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 55 x 70 x 35 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
span = 55;                // outer length, X
outer_w = 70;             // outer width, Y
wall_h = 35;              // upright height, Z
plate_t = 5;              // wall thickness
hole_d = 4.5;             // clearance for M4

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = plate_t + 5, d = hole_d);
}
module hole_y_pz(pz) {
  /* through both uprights along Y */
  translate([0, -2.5, pz]) rotate([-90, 0, 0]) cylinder(h = outer_w + 5, d = hole_d);
}

module base() {
  cube([span, outer_w, plate_t]);
}

module uprights() {
  cube([span, plate_t, wall_h]);
  translate([0, outer_w - plate_t, 0]) cube([span, plate_t, wall_h]);
}

difference() {
  union() {
    base();
    uprights();
  }
  hole_z(9, 35);
  hole_z(46, 35);
  hole_y_pz(21);
}
