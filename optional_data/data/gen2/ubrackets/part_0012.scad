$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 110 x 35 x 55 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 110;             // outer length, X
width = 35;               // outer width, Y
height = 55;              // upright height, Z
thick = 4.5;              // wall thickness
hole_d = 6.6;             // clearance for M6
window_l = 44;            // window length
window_h = 23.6;          // window height

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
  hole_z(13.2, 17.5);
  hole_z(96.8, 17.5);
  /* lightening window through both uprights */
  translate([length / 2 - window_l / 2, -1, thick + 4])
    cube([window_l, width + 2, window_h]);
}
