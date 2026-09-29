$fn = 32;

// ----------------------------------------------------------------------
// Impeller: 70 mm, 8 blades, 38 mm tall
// ----------------------------------------------------------------------

// --- parameters (mm) ---
center_d = 23.8;          // hub diameter
center_h = 12;            // hub height
wheel_d = 70;             // outer diameter over the blades
blade_count = 8;          // number of blades
blade_t = 1.6;            // blade thickness
blade_h = 26;             // blade height
blade_in_r = 10.9;        // blade root radius
blade_out_r = 33.4;       // blade tip radius
sweep = 20;               // blade sweep, degrees
bore_d = 5;               // shaft bore

module hub() {
  cylinder(h = center_h, d = center_d);
}

module blade() {
  /* blade swept between two boxes: hull of the root and the tip section */
  hull() {
    translate([blade_in_r, 0, center_h - 1])
      cube([blade_t, blade_t * 2.2, blade_h + 1], center = false);
    rotate([0, 0, sweep])
      translate([blade_out_r, 0, center_h - 1])
        cube([blade_t, blade_t * 1.6, blade_h + 1], center = false);
  }
}

module blades() {
  for (i = [0 : blade_count - 1])
    rotate([0, 0, i * 360 / blade_count]) blade();
}

difference() {
  union() {
    hub();
    blades();
  }
  translate([0, 0, -1]) cylinder(h = center_h + blade_h + 0 + 3, d = bore_d);
}
