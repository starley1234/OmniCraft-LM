$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 45 x 70 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 45;              // outer length, X
width = 70;               // outer width, Y
height = 25;              // upright height, Z
thick = 4.5;              // wall thickness
hole_d = 3.4;             // clearance for M3

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
  hole_z(22.5, 35);
}
