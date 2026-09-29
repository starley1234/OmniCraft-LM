$fn = 32;

// ----------------------------------------------------------------------
// Impeller: 100 mm, 9 blades, 35 mm tall
// ----------------------------------------------------------------------

// --- parameters (mm) ---
boss_d = 33;              // hub diameter
boss_h = 10;              // hub height
rotor_d = 100;            // outer diameter over the blades
vane_count = 9;           // number of blades
blade_t = 2.4;            // blade thickness
blade_h = 22;             // blade height
blade_in_r = 15.5;        // blade root radius
blade_out_r = 47.6;       // blade tip radius
sweep = 10;               // blade sweep, degrees
bore_d = 6;               // shaft bore
shroud_h = 3;             // shroud ring thickness
shroud_d = 102;           // shroud outside diameter

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

module shroud() {
  translate([0, 0, boss_h + blade_h - 1])
    difference() {
      cylinder(h = shroud_h + 1, d = shroud_d);
      translate([0, 0, -1]) cylinder(h = shroud_h + 3, d = shroud_d - 2 * 3);
    }
}

difference() {
  union() {
    hub();
    blades();
    shroud();
  }
  translate([0, 0, -1]) cylinder(h = boss_h + blade_h + shroud_h + 3, d = bore_d);
}
