$fn = 32;

// ----------------------------------------------------------------------
// Hinge leaf: 40 x 40 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
leaf_len = 40;            // leaf length, X
leaf_w = 35;              // leaf width, Y
leaf_t = 5;               // leaf thickness
knuckle_d = 10;           // knuckle diameter
knuckle_w = 10.67;        // knuckle width
knuckle_n = 3;            // number of knuckles
pin_d = 3.8;              // pin bore
gap = 2;                  // gap between the knuckles
screw_d = 5.5;            // screw clearance

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
  translate([10, leaf_w * 0.6, -1]) cylinder(h = leaf_t + 2, d = screw_d);
  translate([20, leaf_w * 0.6, -1]) cylinder(h = leaf_t + 2, d = screw_d);
  translate([30, leaf_w * 0.6, -1]) cylinder(h = leaf_t + 2, d = screw_d);
}
