$fn = 32;

// ----------------------------------------------------------------------
// Hinge leaf: 40 x 29 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_len = 40;           // leaf length, X
plate_w = 25;             // leaf width, Y
plate_t = 4;              // leaf thickness
barrel_d = 8;             // knuckle diameter
barrel_w = 10;            // knuckle width
knuckle_n = 3;            // number of knuckles
pin_d = 3.04;             // pin bore
gap = 2.5;                // gap between the knuckles
screw_d = 4.5;            // screw clearance
cs_d = 7.7;               // countersink diameter
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
  translate([8, plate_w * 0.6, -1]) cylinder(h = plate_t + 2, d = screw_d);
  translate([8, plate_w * 0.6, plate_t - cs_h]) cylinder(h = cs_h + 0.5, d = cs_d);
  translate([16, plate_w * 0.6, -1]) cylinder(h = plate_t + 2, d = screw_d);
  translate([16, plate_w * 0.6, plate_t - cs_h]) cylinder(h = cs_h + 0.5, d = cs_d);
  translate([24, plate_w * 0.6, -1]) cylinder(h = plate_t + 2, d = screw_d);
  translate([24, plate_w * 0.6, plate_t - cs_h]) cylinder(h = cs_h + 0.5, d = cs_d);
  translate([32, plate_w * 0.6, -1]) cylinder(h = plate_t + 2, d = screw_d);
  translate([32, plate_w * 0.6, plate_t - cs_h]) cylinder(h = cs_h + 0.5, d = cs_d);
}
