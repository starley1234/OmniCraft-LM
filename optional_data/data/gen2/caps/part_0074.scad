$fn = 32;

// ----------------------------------------------------------------------
// Retaining cap: 6000 cover, 50 mm, spigot 25.8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_d = 50;             // cover diameter
plate_t = 8;              // cover thickness
boss_d = 25.8;            // spigot that enters the housing
boss_h = 4;               // spigot height
shaft_d = 10.3;           // shaft opening
bolt_d = 5.5;             // bolt clearance
bolt_r = 18.95;           // bolt circle radius

module cover() {
  cylinder(h = plate_t, d = plate_d);
}

module spigot() {
  /* sunk 1 mm into the cover; the spigot sets the overall height */
  translate([0, 0, -boss_h]) cylinder(h = boss_h + 1, d = boss_d);
}

difference() {
  union() {
    cover();
    spigot();
  }
  for (i = [0 : 3]) rotate([0, 0, 45 + i * 90]) translate([bolt_r, 0, -boss_h - 1])
    cylinder(h = boss_h + plate_t + 2, d = bolt_d);
  translate([0, 0, -boss_h - 1]) cylinder(h = boss_h + plate_t + 2, d = shaft_d);
}
