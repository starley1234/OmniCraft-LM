$fn = 32;

// ----------------------------------------------------------------------
// Hinge leaf: 60 x 47 x 14 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tab_len = 60;             // leaf length, X
tab_w = 40;               // leaf width, Y
tab_t = 4;                // leaf thickness
ring_d = 14;              // knuckle diameter
ring_w = 27;              // knuckle width
knuckle_n = 2;            // number of knuckles
pin_d = 6.3;              // pin bore
gap = 2;                  // gap between the knuckles
screw_d = 3.4;            // screw clearance
cs_d = 6.6;               // countersink diameter
cs_h = 1.4;               // countersink depth

module leaf() {
  cube([tab_len, tab_w, tab_t]);
}

module knuckles() {
  /* barrels sit on the leaf edge, the pin axis at half the leaf thickness */
  for (i = [0 : knuckle_n - 1])
    translate([gap + i * (ring_w + gap), 0, tab_t * 0.5])
      rotate([0, 90, 0]) cylinder(h = ring_w, d = ring_d);
}

difference() {
  union() {
    leaf();
    knuckles();
  }
  rotate([0, 90, 0]) translate([0, 0, -1])
    cylinder(h = tab_len + 2, d = pin_d);
  translate([12, tab_w * 0.6, -1]) cylinder(h = tab_t + 2, d = screw_d);
  translate([12, tab_w * 0.6, tab_t - cs_h]) cylinder(h = cs_h + 0.5, d = cs_d);
  translate([24, tab_w * 0.6, -1]) cylinder(h = tab_t + 2, d = screw_d);
  translate([24, tab_w * 0.6, tab_t - cs_h]) cylinder(h = cs_h + 0.5, d = cs_d);
  translate([36, tab_w * 0.6, -1]) cylinder(h = tab_t + 2, d = screw_d);
  translate([36, tab_w * 0.6, tab_t - cs_h]) cylinder(h = cs_h + 0.5, d = cs_d);
  translate([48, tab_w * 0.6, -1]) cylinder(h = tab_t + 2, d = screw_d);
  translate([48, tab_w * 0.6, tab_t - cs_h]) cylinder(h = cs_h + 0.5, d = cs_d);
}
