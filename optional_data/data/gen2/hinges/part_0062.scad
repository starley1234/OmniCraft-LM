$fn = 32;

// ----------------------------------------------------------------------
// Hinge leaf: 100 x 50 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tab_len = 100;            // leaf length, X
tab_w = 45;               // leaf width, Y
tab_t = 5;                // leaf thickness
ring_d = 10;              // knuckle diameter
ring_w = 31.33;           // knuckle width
knuckle_n = 3;            // number of knuckles
pin_d = 3.8;              // pin bore
gap = 1.5;                // gap between the knuckles
screw_d = 5.5;            // screw clearance
cs_d = 8.7;               // countersink diameter
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
  translate([25, tab_w * 0.6, -1]) cylinder(h = tab_t + 2, d = screw_d);
  translate([25, tab_w * 0.6, tab_t - cs_h]) cylinder(h = cs_h + 0.5, d = cs_d);
  translate([50, tab_w * 0.6, -1]) cylinder(h = tab_t + 2, d = screw_d);
  translate([50, tab_w * 0.6, tab_t - cs_h]) cylinder(h = cs_h + 0.5, d = cs_d);
  translate([75, tab_w * 0.6, -1]) cylinder(h = tab_t + 2, d = screw_d);
  translate([75, tab_w * 0.6, tab_t - cs_h]) cylinder(h = cs_h + 0.5, d = cs_d);
}
