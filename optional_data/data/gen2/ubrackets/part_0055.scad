$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 50 x 30 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_len = 50;            // outer length, X
jaw_w = 30;               // outer width, Y
jaw_h = 50;               // upright height, Z
web_t = 4.5;              // wall thickness
hole_d = 9;               // clearance for M8

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
  hole_z(18, 15);
  hole_z(32, 15);
  hole_y_pz(18);
  hole_y_pz(32);
}
