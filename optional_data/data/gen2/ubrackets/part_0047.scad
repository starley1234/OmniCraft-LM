$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 100 x 70 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_len = 100;           // outer length, X
channel_w = 70;           // outer width, Y
upright_h = 60;           // upright height, Z
mat_t = 3;                // wall thickness
hole_d = 4.5;             // clearance for M4

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = mat_t + 5, d = hole_d);
}
module hole_y_pz(pz) {
  /* through both uprights along Y */
  translate([0, -2.5, pz]) rotate([-90, 0, 0]) cylinder(h = channel_w + 5, d = hole_d);
}

module base() {
  cube([base_len, channel_w, mat_t]);
}

module uprights() {
  cube([base_len, mat_t, upright_h]);
  translate([0, channel_w - mat_t, 0]) cube([base_len, mat_t, upright_h]);
}

difference() {
  union() {
    base();
    uprights();
  }
  hole_z(9, 35);
  hole_z(91, 35);
  hole_y_pz(9);
  hole_y_pz(51);
}
