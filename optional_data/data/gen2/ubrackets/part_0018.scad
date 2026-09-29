$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 40 x 50 x 30 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_len = 40;            // outer length, X
jaw_w = 50;               // outer width, Y
jaw_h = 30;               // upright height, Z
web_t = 5;                // wall thickness
hole_d = 9;               // clearance for M8

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
  hole_z(20, 25);
  hole_y_pz(18);
}
