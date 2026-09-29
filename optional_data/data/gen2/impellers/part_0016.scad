$fn = 32;

// ----------------------------------------------------------------------
// Impeller: 90 mm, 12 blades, 22 mm tall
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hub_d = 28.8;             // hub diameter
hub_h = 8;                // hub height
imp_d = 90;               // outer diameter over the blades
blades = 12;              // number of blades
blade_t = 1.6;            // blade thickness
blade_h = 14;             // blade height
blade_in_r = 13.4;        // blade root radius
blade_out_r = 43.4;       // blade tip radius
sweep = 10;               // blade sweep, degrees
bore_d = 5;               // shaft bore

module hub() {
  cylinder(h = hub_h, d = hub_d);
}

module blade() {
  /* blade swept between two boxes: hull of the root and the tip section */
  hull() {
    translate([blade_in_r, 0, hub_h - 1])
      cube([blade_t, blade_t * 2.2, blade_h + 1], center = false);
    rotate([0, 0, sweep])
      translate([blade_out_r, 0, hub_h - 1])
        cube([blade_t, blade_t * 1.6, blade_h + 1], center = false);
  }
}

module blades() {
  for (i = [0 : blades - 1])
    rotate([0, 0, i * 360 / blades]) blade();
}

difference() {
  union() {
    hub();
    blades();
  }
  translate([0, 0, -1]) cylinder(h = hub_h + blade_h + 0 + 3, d = bore_d);
}
