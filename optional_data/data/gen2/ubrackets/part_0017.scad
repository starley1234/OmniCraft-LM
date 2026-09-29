$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 70 x 45 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
span = 70;                // outer length, X
outer_w = 45;             // outer width, Y
wall_h = 50;              // upright height, Z
plate_t = 4.5;            // wall thickness
hole_d = 5.5;             // clearance for M5

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
  hole_z(11, 22.5);
  hole_z(59, 22.5);
}
