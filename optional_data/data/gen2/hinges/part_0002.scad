$fn = 32;

// ----------------------------------------------------------------------
// Hinge leaf: 100 x 51 x 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_len = 100;          // leaf length, X
plate_w = 45;             // leaf width, Y
plate_t = 6;              // leaf thickness
barrel_d = 12;            // knuckle diameter
barrel_w = 46.25;         // knuckle width
knuckle_n = 2;            // number of knuckles
pin_d = 3.84;             // pin bore
gap = 2.5;                // gap between the knuckles
screw_d = 4.5;            // screw clearance

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
  translate([50, plate_w * 0.6, -1]) cylinder(h = plate_t + 2, d = screw_d);
  translate([75, plate_w * 0.6, -1]) cylinder(h = plate_t + 2, d = screw_d);
}
