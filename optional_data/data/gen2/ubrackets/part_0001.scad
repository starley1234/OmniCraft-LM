$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 50 x 50 x 45 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_len = 50;            // outer length, X
jaw_w = 50;               // outer width, Y
jaw_h = 45;               // upright height, Z
web_t = 6;                // wall thickness
hole_d = 9;               // clearance for M8
window_l = 22;            // window length
window_h = 18.9;          // window height

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = web_t + 5, d = hole_d);
}
module hole_y_pz(pz) {
  /* through both uprights along Y */
  translate([0, -2.5, pz]) rotate([-90, 0, 0]) cylinder(h = jaw_w + 5, d = hole_d);
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
  hole_z(18, 25);
  hole_z(32, 25);
  /* lightening window through both uprights */
  translate([rail_len / 2 - window_l / 2, -1, web_t + 4])
    cube([window_l, jaw_w + 2, window_h]);
}
