$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 60 x 60 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
rail_len = 60;            // outer length, X
jaw_w = 60;               // outer width, Y
jaw_h = 60;               // upright height, Z
web_t = 5;                // wall thickness
hole_d = 6.6;             // clearance for M6
cb_d = 11;                // counterbore diameter
cb_h = 3;                 // counterbore depth

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = web_t + 1, d = hole_d);
}
module hole_y_pz(pz) {
  /* through both uprights along Y */
  translate([0, -0.5, pz]) rotate([-90, 0, 0]) cylinder(h = jaw_w + 1, d = hole_d);
}
module cb_z(px, py) {
  translate([px, py, web_t - cb_h]) cylinder(h = cb_h + 0.4, d = cb_d);
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
  hole_z(13.2, 30);
  cb_z(13.2, 30);
  hole_z(46.8, 30);
  cb_z(46.8, 30);
}
