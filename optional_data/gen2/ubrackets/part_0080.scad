$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 55 x 45 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_len = 55;            // outer length, X
jaw_w = 45;               // outer width, Y
jaw_h = 50;               // upright height, Z
web_t = 8;                // wall thickness
hole_d = 6.6;             // clearance for M6

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
  hole_z(13.2, 22.5);
  hole_z(41.8, 22.5);
}
