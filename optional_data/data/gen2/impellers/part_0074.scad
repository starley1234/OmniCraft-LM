$fn = 32;

// ----------------------------------------------------------------------
// Impeller: 50 mm, 12 blades, 37 mm tall
// ----------------------------------------------------------------------

// --- parameters (mm) ---
boss_d = 17;              // hub diameter
boss_h = 15;              // hub height
rotor_d = 50;             // outer diameter over the blades
vane_count = 12;          // number of blades
blade_t = 3;              // blade thickness
blade_h = 22;             // blade height
blade_in_r = 7.5;         // blade root radius
blade_out_r = 22;         // blade tip radius
sweep = 10;               // blade sweep, degrees
bore_d = 6;               // shaft bore

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
