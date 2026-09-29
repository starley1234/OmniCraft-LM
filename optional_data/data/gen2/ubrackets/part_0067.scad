$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 50 x 40 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_len = 50;            // outer length, X
jaw_w = 40;               // outer width, Y
jaw_h = 50;               // upright height, Z
web_t = 6;                // wall thickness
hole_d = 4.5;             // clearance for M4
window_l = 20.5;          // window length
window_h = 18.5;          // window height

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
  hole_z(9, 20);
  hole_z(41, 20);
  /* lightening window through both uprights */
  translate([rail_len / 2 - window_l / 2, -1, web_t + 4])
    cube([window_l, jaw_w + 2, window_h]);
}
