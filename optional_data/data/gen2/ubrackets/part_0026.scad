$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 70 x 55 x 45 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_len = 70;            // outer length, X
channel_w = 55;           // outer width, Y
upright_h = 45;           // upright height, Z
mat_t = 4;                // wall thickness
hole_d = 9;               // clearance for M8
window_l = 25.9;          // window length
window_h = 17.6;          // window height

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
  hole_z(18, 27.5);
  hole_z(52, 27.5);
  /* lightening window through both uprights */
  translate([base_len / 2 - window_l / 2, -1, mat_t + 4])
    cube([window_l, channel_w + 2, window_h]);
}
