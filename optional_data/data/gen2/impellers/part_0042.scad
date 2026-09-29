$fn = 32;

// ----------------------------------------------------------------------
// Impeller: 100 mm, 6 blades, 28 mm tall
// ----------------------------------------------------------------------

// --- parameters (mm) ---
boss_d = 27;              // hub diameter
boss_h = 18;              // hub height
rotor_d = 100;            // outer diameter over the blades
vane_count = 6;           // number of blades
blade_t = 2.4;            // blade thickness
blade_h = 10;             // blade height
blade_in_r = 12.5;        // blade root radius
blade_out_r = 47.6;       // blade tip radius
sweep = 30;               // blade sweep, degrees
bore_d = 10;              // shaft bore

module hub() {
  cylinder(h = boss_h, d = boss_d);
}

module blade() {
  /* blade swept between two boxes: hull of the root and the tip section */
  hull() {
    translate([blade_in_r, 0, boss_h - 1])
      cube([blade_t, blade_t * 2.2, blade_h + 1], center = false);
    rotate([0, 0, sweep])
      translate([blade_out_r, 0, boss_h - 1])
        cube([blade_t, blade_t * 1.6, blade_h + 1], center = false);
  }
}

module blades() {
  for (i = [0 : vane_count - 1])
    rotate([0, 0, i * 360 / vane_count]) blade();
}

difference() {
  union() {
    hub();
    blades();
  }
  translate([0, 0, -1]) cylinder(h = boss_h + blade_h + 0 + 3, d = bore_d);
}
