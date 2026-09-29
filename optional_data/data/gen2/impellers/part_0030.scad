$fn = 32;

// ----------------------------------------------------------------------
// Impeller: 70 mm, 6 blades, 34 mm tall
// ----------------------------------------------------------------------

// --- parameters (mm) ---
boss_d = 20.3;            // hub diameter
boss_h = 8;               // hub height
rotor_d = 70;             // outer diameter over the blades
vane_count = 6;           // number of blades
blade_t = 1.6;            // blade thickness
blade_h = 26;             // blade height
blade_in_r = 9.15;        // blade root radius
blade_out_r = 33.4;       // blade tip radius
sweep = 20;               // blade sweep, degrees
bore_d = 8;               // shaft bore

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
