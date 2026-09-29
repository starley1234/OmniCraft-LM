$fn = 32;

// ----------------------------------------------------------------------
// Impeller: 50 mm, 6 blades, 28 mm tall
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hub_d = 15.5;             // hub diameter
hub_h = 15;               // hub height
imp_d = 50;               // outer diameter over the blades
blades = 6;               // number of blades
blade_t = 1.6;            // blade thickness
blade_h = 10;             // blade height
blade_in_r = 6.75;        // blade root radius
blade_out_r = 23.4;       // blade tip radius
sweep = 25;               // blade sweep, degrees
bore_d = 5;               // shaft bore
shroud_h = 3;             // shroud ring thickness
shroud_d = 52;            // shroud outside diameter

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

module shroud() {
  translate([0, 0, hub_h + blade_h - 1])
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
  translate([0, 0, -1]) cylinder(h = hub_h + blade_h + shroud_h + 3, d = bore_d);
}
