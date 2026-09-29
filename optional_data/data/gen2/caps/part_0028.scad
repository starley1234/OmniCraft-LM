$fn = 32;

// ----------------------------------------------------------------------
// Retaining cap: 6000 cover, 46 mm, spigot 25.8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_d = 46;             // cover diameter
plate_t = 4;              // cover thickness
boss_d = 25.8;            // spigot that enters the housing
boss_h = 4;               // spigot height
bolt_d = 3.4;             // bolt clearance
bolt_r = 17.95;           // bolt circle radius

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
}
