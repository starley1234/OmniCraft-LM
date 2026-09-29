$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 80 x 60 x 55 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 80;              // outer length, X
width = 60;               // outer width, Y
height = 55;              // upright height, Z
thick = 8;                // wall thickness
hole_d = 4.5;             // clearance for M4

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
  hole_z(9, 30);
  hole_z(71, 30);
}
