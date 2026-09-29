$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 40 x 40 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_len = 40;            // outer length, X
channel_w = 40;           // outer width, Y
upright_h = 50;           // upright height, Z
mat_t = 6;                // wall thickness
hole_d = 6.6;             // clearance for M6

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = mat_t + 1, d = hole_d);
}
module hole_y_pz(pz) {
  /* through both uprights along Y */
  translate([0, -0.5, pz]) rotate([-90, 0, 0]) cylinder(h = channel_w + 1, d = hole_d);
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
  hole_z(20, 20);
}
