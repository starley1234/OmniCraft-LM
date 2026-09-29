$fn = 32;

// ----------------------------------------------------------------------
// Impeller: 100 mm, 12 blades, 35 mm tall
// ----------------------------------------------------------------------

// --- parameters (mm) ---
center_d = 29;            // hub diameter
center_h = 18;            // hub height
wheel_d = 100;            // outer diameter over the blades
blade_count = 12;         // number of blades
blade_t = 3;              // blade thickness
blade_h = 14;             // blade height
blade_in_r = 13.5;        // blade root radius
blade_out_r = 47;         // blade tip radius
sweep = 20;               // blade sweep, degrees
bore_d = 5;               // shaft bore
shroud_h = 3;             // shroud ring thickness
shroud_d = 102;           // shroud outside diameter

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

module shroud() {
  translate([0, 0, center_h + blade_h - 1])
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
  translate([0, 0, -1]) cylinder(h = center_h + blade_h + shroud_h + 3, d = bore_d);
}
