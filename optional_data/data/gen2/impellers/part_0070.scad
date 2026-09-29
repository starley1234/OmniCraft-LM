$fn = 32;

// ----------------------------------------------------------------------
// Impeller: 80 mm, 7 blades, 30 mm tall
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hub_d = 23.2;             // hub diameter
hub_h = 8;                // hub height
imp_d = 80;               // outer diameter over the blades
blades = 7;               // number of blades
blade_t = 3;              // blade thickness
blade_h = 22;             // blade height
blade_in_r = 10.6;        // blade root radius
blade_out_r = 37;         // blade tip radius
sweep = 20;               // blade sweep, degrees
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
