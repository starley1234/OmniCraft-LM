$fn = 32;

// ----------------------------------------------------------------------
// Hinge leaf: 80 x 39 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
leaf_len = 80;            // leaf length, X
leaf_w = 35;              // leaf width, Y
leaf_t = 3;               // leaf thickness
knuckle_d = 8;            // knuckle diameter
knuckle_w = 24;           // knuckle width
knuckle_n = 3;            // number of knuckles
pin_d = 3.04;             // pin bore
gap = 2;                  // gap between the knuckles
screw_d = 3.4;            // screw clearance
cs_d = 6.6;               // countersink diameter
cs_h = 1.4;               // countersink depth

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
  translate([16, leaf_w * 0.6, -1]) cylinder(h = leaf_t + 2, d = screw_d);
  translate([16, leaf_w * 0.6, leaf_t - cs_h]) cylinder(h = cs_h + 0.5, d = cs_d);
  translate([32, leaf_w * 0.6, -1]) cylinder(h = leaf_t + 2, d = screw_d);
  translate([32, leaf_w * 0.6, leaf_t - cs_h]) cylinder(h = cs_h + 0.5, d = cs_d);
  translate([48, leaf_w * 0.6, -1]) cylinder(h = leaf_t + 2, d = screw_d);
  translate([48, leaf_w * 0.6, leaf_t - cs_h]) cylinder(h = cs_h + 0.5, d = cs_d);
  translate([64, leaf_w * 0.6, -1]) cylinder(h = leaf_t + 2, d = screw_d);
  translate([64, leaf_w * 0.6, leaf_t - cs_h]) cylinder(h = cs_h + 0.5, d = cs_d);
}
