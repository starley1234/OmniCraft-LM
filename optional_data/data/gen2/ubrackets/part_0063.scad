$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 55 x 70 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_len = 55;            // outer length, X
channel_w = 70;           // outer width, Y
upright_h = 60;           // upright height, Z
mat_t = 3;                // wall thickness
hole_d = 3.4;             // clearance for M3

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
  hole_z(6.8, 35);
  hole_z(48.2, 35);
}
