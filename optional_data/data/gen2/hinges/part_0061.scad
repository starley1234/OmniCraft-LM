$fn = 32;

// ----------------------------------------------------------------------
// Hinge leaf: 100 x 41 x 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
leaf_len = 100;           // leaf length, X
leaf_w = 35;              // leaf width, Y
leaf_t = 6;               // leaf thickness
knuckle_d = 12;           // knuckle diameter
knuckle_w = 23.12;        // knuckle width
knuckle_n = 4;            // number of knuckles
pin_d = 4.56;             // pin bore
gap = 1.5;                // gap between the knuckles
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
  translate([30, leaf_w * 0.6, -1]) cylinder(h = leaf_t + 2, d = screw_d);
  translate([70, leaf_w * 0.6, -1]) cylinder(h = leaf_t + 2, d = screw_d);
}
