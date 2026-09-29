$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 40 x 55 x 30 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 40;              // outer length, X
width = 55;               // outer width, Y
height = 30;              // upright height, Z
thick = 8;                // wall thickness
hole_d = 9;               // clearance for M8

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = thick + 1, d = hole_d);
}
module hole_y_pz(pz) {
  /* through both uprights along Y */
  translate([0, -0.5, pz]) rotate([-90, 0, 0]) cylinder(h = width + 1, d = hole_d);
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
  hole_z(20, 27.5);
  hole_y_pz(18);
}
