$fn = 32;

// ----------------------------------------------------------------------
// Hinge leaf: 100 x 36 x 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_len = 100;          // leaf length, X
plate_w = 30;             // leaf width, Y
plate_t = 5;              // leaf thickness
barrel_d = 12;            // knuckle diameter
barrel_w = 30.67;         // knuckle width
knuckle_n = 3;            // number of knuckles
pin_d = 5.4;              // pin bore
gap = 2;                  // gap between the knuckles
screw_d = 3.4;            // screw clearance

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
  translate([30, plate_w * 0.6, -1]) cylinder(h = plate_t + 2, d = screw_d);
  translate([70, plate_w * 0.6, -1]) cylinder(h = plate_t + 2, d = screw_d);
}
