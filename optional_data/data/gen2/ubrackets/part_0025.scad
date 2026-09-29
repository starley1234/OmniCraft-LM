$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 60 x 40 x 55 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 60;              // outer length, X
width = 40;               // outer width, Y
height = 55;              // upright height, Z
thick = 4;                // wall thickness
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
  hole_z(6.8, 20);
  hole_z(53.2, 20);
}
