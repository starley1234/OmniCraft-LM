$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 70 x 55 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 70;              // outer length, X
width = 55;               // outer width, Y
height = 40;              // upright height, Z
thick = 4;                // wall thickness
hole_d = 4.5;             // clearance for M4
window_l = 24.5;          // window length
window_h = 13.6;          // window height

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
  hole_z(9, 27.5);
  hole_z(61, 27.5);
  /* lightening window through both uprights */
  translate([length / 2 - window_l / 2, -1, thick + 4])
    cube([window_l, width + 2, window_h]);
}
