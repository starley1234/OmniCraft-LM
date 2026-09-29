$fn = 32;

// ----------------------------------------------------------------------
// Hinge leaf: 100 x 37 x 14 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tab_len = 100;            // leaf length, X
tab_w = 30;               // leaf width, Y
tab_t = 5;                // leaf thickness
ring_d = 14;              // knuckle diameter
ring_w = 30;              // knuckle width
knuckle_n = 3;            // number of knuckles
pin_d = 4.48;             // pin bore
gap = 2.5;                // gap between the knuckles
screw_d = 4.5;            // screw clearance

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
  translate([20, tab_w * 0.6, -1]) cylinder(h = tab_t + 2, d = screw_d);
  translate([40, tab_w * 0.6, -1]) cylinder(h = tab_t + 2, d = screw_d);
  translate([60, tab_w * 0.6, -1]) cylinder(h = tab_t + 2, d = screw_d);
  translate([80, tab_w * 0.6, -1]) cylinder(h = tab_t + 2, d = screw_d);
}
