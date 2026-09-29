$fn = 32;

// ----------------------------------------------------------------------
// Retaining cap: 6002 cover, 56 mm, spigot 31.9 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_d = 56;             // cover diameter
plate_t = 5;              // cover thickness
boss_d = 31.9;            // spigot that enters the housing
boss_h = 3;               // spigot height
shaft_d = 15.3;           // shaft opening
bolt_d = 6.6;             // bolt clearance
bolt_r = 21.98;           // bolt circle radius
dome_h = 2;               // raised centre

module cover() {
  cylinder(h = plate_t, d = plate_d);
}

module spigot() {
  /* sunk 1 mm into the cover; the spigot sets the overall height */
  translate([0, 0, -boss_h]) cylinder(h = boss_h + 1, d = boss_d);
}

module dome() {
  translate([0, 0, plate_t - 1]) cylinder(h = dome_h + 1, d = plate_d * 0.55);
}

difference() {
  union() {
    cover();
    spigot();
    dome();
  }
  for (i = [0 : 3]) rotate([0, 0, 45 + i * 90]) translate([bolt_r, 0, -boss_h - 1])
    cylinder(h = boss_h + plate_t + 2, d = bolt_d);
  translate([0, 0, -boss_h - 1]) cylinder(h = boss_h + plate_t + 2, d = shaft_d);
}
