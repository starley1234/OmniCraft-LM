$fn = 32;

// ----------------------------------------------------------------------
// Hinge leaf: 100 x 52 x 14 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
leaf_len = 100;           // leaf length, X
leaf_w = 45;              // leaf width, Y
leaf_t = 4;               // leaf thickness
knuckle_d = 14;           // knuckle diameter
knuckle_w = 30;           // knuckle width
knuckle_n = 3;            // number of knuckles
pin_d = 4.48;             // pin bore
gap = 2.5;                // gap between the knuckles
screw_d = 4.5;            // screw clearance

module leaf() {
  cube([leaf_len, leaf_w, leaf_t]);
}

module knuckles() {
  /* barrels sit on the leaf edge, the pin axis at half the leaf thickness */
  for (i = [0 : knuckle_n - 1])
    translate([gap + i * (knuckle_w + gap), 0, leaf_t * 0.5])
      rotate([0, 90, 0]) cylinder(h = knuckle_w, d = knuckle_d);
}

difference() {
  union() {
    leaf();
    knuckles();
  }
  rotate([0, 90, 0]) translate([0, 0, -1])
    cylinder(h = leaf_len + 2, d = pin_d);
  translate([20, leaf_w * 0.6, -1]) cylinder(h = leaf_t + 2, d = screw_d);
  translate([40, leaf_w * 0.6, -1]) cylinder(h = leaf_t + 2, d = screw_d);
  translate([60, leaf_w * 0.6, -1]) cylinder(h = leaf_t + 2, d = screw_d);
  translate([80, leaf_w * 0.6, -1]) cylinder(h = leaf_t + 2, d = screw_d);
}
