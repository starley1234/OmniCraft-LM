$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 45 x 45 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_len = 45;            // outer length, X
channel_w = 45;           // outer width, Y
upright_h = 50;           // upright height, Z
mat_t = 5;                // wall thickness
hole_d = 5.5;             // clearance for M5
window_l = 18;            // window length
window_h = 17.5;          // window height

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
  hole_z(22.5, 22.5);
  /* lightening window through both uprights */
  translate([base_len / 2 - window_l / 2, -1, mat_t + 4])
    cube([window_l, channel_w + 2, window_h]);
}
