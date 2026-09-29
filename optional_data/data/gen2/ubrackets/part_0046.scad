$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 100 x 30 x 45 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_len = 100;           // outer length, X
jaw_w = 30;               // outer width, Y
jaw_h = 45;               // upright height, Z
web_t = 8;                // wall thickness
hole_d = 5.5;             // clearance for M5
window_l = 42;            // window length
window_h = 17.6;          // window height

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = web_t + 1, d = hole_d);
}
module hole_y_pz(pz) {
  /* through both uprights along Y */
  translate([0, -0.5, pz]) rotate([-90, 0, 0]) cylinder(h = jaw_w + 1, d = hole_d);
}

module base() {
  cube([rail_len, jaw_w, web_t]);
}

module uprights() {
  cube([rail_len, web_t, jaw_h]);
  translate([0, jaw_w - web_t, 0]) cube([rail_len, web_t, jaw_h]);
}

difference() {
  union() {
    base();
    uprights();
  }
  hole_z(11, 15);
  hole_z(89, 15);
  /* lightening window through both uprights */
  translate([rail_len / 2 - window_l / 2, -1, web_t + 4])
    cube([window_l, jaw_w + 2, window_h]);
}
