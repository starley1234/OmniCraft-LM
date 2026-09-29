$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 80 x 60 x 45 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_len = 80;            // outer length, X
jaw_w = 60;               // outer width, Y
jaw_h = 45;               // upright height, Z
web_t = 4;                // wall thickness
hole_d = 4.5;             // clearance for M4

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
  hole_z(9, 30);
  hole_z(71, 30);
  hole_y_pz(9);
  hole_y_pz(36);
}
