$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 80 x 70 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 80;              // outer length, X
width = 70;               // outer width, Y
height = 25;              // upright height, Z
thick = 5;                // wall thickness
hole_d = 4.5;             // clearance for M4
slot_l = 24;              // slot length

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = thick + 5, d = hole_d);
}
module hole_y_pz(pz) {
  /* through both uprights along Y */
  translate([0, -2.5, pz]) rotate([-90, 0, 0]) cylinder(h = width + 5, d = hole_d);
}
module slot_z(px, py) {
  hull() {
    translate([px - (slot_l - hole_d) / 2, py, -2.5]) cylinder(h = thick + 5, d = hole_d);
    translate([px + (slot_l - hole_d) / 2, py, -2.5]) cylinder(h = thick + 5, d = hole_d);
  }
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
  slot_z(40, 35);
}
