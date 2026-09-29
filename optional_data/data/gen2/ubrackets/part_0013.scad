$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 100 x 30 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 100;             // outer length, X
width = 30;               // outer width, Y
height = 60;              // upright height, Z
thick = 3;                // wall thickness
hole_d = 5.5;             // clearance for M5

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
  hole_z(11, 15);
  hole_z(89, 15);
}
