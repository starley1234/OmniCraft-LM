$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 70 x 50 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 70;              // outer length, X
width = 50;               // outer width, Y
height = 25;              // upright height, Z
thick = 6;                // wall thickness
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
  hole_z(18, 25);
  hole_z(52, 25);
}
