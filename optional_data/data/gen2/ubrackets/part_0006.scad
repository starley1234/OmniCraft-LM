$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 110 x 70 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 110;             // outer length, X
width = 70;               // outer width, Y
height = 25;              // upright height, Z
thick = 3;                // wall thickness
hole_d = 5.5;             // clearance for M5

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = thick + 5, d = hole_d);
}
module hole_y_pz(pz) {
  /* through both uprights along Y */
  translate([0, -2.5, pz]) rotate([-90, 0, 0]) cylinder(h = width + 5, d = hole_d);
}

module base() {
  cube([length, width, thick]);
}

module uprights() {
  cube([length, thick, height]);
  translate([0, width - thick, 0]) cube([length, thick, height]);
}

difference() {
  union() {
    base();
    uprights();
  }
  hole_z(11, 35);
  hole_z(99, 35);
}
