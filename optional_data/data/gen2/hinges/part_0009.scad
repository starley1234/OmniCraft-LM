$fn = 32;

// ----------------------------------------------------------------------
// Hinge leaf: 100 x 45 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_len = 100;          // leaf length, X
plate_w = 40;             // leaf width, Y
plate_t = 4;              // leaf thickness
barrel_d = 10;            // knuckle diameter
barrel_w = 45.5;          // knuckle width
knuckle_n = 2;            // number of knuckles
pin_d = 3.2;              // pin bore
gap = 3;                  // gap between the knuckles
screw_d = 3.4;            // screw clearance
cs_d = 6.6;               // countersink diameter
cs_h = 1.4;               // countersink depth

module leaf() {
  cube([plate_len, plate_w, plate_t]);
}

module knuckles() {
  /* barrels sit on the leaf edge, the pin axis at half the leaf thickness */
  for (i = [0 : knuckle_n - 1])
    translate([gap + i * (barrel_w + gap), 0, plate_t * 0.5])
      rotate([0, 90, 0]) cylinder(h = barrel_w, d = barrel_d);
}

difference() {
  union() {
    leaf();
    knuckles();
  }
  rotate([0, 90, 0]) translate([0, 0, -1])
    cylinder(h = plate_len + 2, d = pin_d);
  translate([25, plate_w * 0.6, -1]) cylinder(h = plate_t + 2, d = screw_d);
  translate([25, plate_w * 0.6, plate_t - cs_h]) cylinder(h = cs_h + 0.5, d = cs_d);
  translate([50, plate_w * 0.6, -1]) cylinder(h = plate_t + 2, d = screw_d);
  translate([50, plate_w * 0.6, plate_t - cs_h]) cylinder(h = cs_h + 0.5, d = cs_d);
  translate([75, plate_w * 0.6, -1]) cylinder(h = plate_t + 2, d = screw_d);
  translate([75, plate_w * 0.6, plate_t - cs_h]) cylinder(h = cs_h + 0.5, d = cs_d);
}
