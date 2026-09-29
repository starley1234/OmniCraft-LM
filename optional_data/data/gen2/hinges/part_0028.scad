$fn = 32;

// ----------------------------------------------------------------------
// Hinge leaf: 50 x 39 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tab_len = 50;             // leaf length, X
tab_w = 35;               // leaf width, Y
tab_t = 4;                // leaf thickness
ring_d = 8;               // knuckle diameter
ring_w = 14;              // knuckle width
knuckle_n = 3;            // number of knuckles
pin_d = 3.04;             // pin bore
gap = 2;                  // gap between the knuckles
screw_d = 3.4;            // screw clearance

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
  translate([12.5, tab_w * 0.6, -1]) cylinder(h = tab_t + 2, d = screw_d);
  translate([25, tab_w * 0.6, -1]) cylinder(h = tab_t + 2, d = screw_d);
  translate([37.5, tab_w * 0.6, -1]) cylinder(h = tab_t + 2, d = screw_d);
}
