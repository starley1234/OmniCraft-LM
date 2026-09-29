$fn = 32;

// ----------------------------------------------------------------------
// Retaining cap: 6001 cover, 44 mm, spigot 27.8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
cover_d = 44;             // cover diameter
cover_t = 6;              // cover thickness
spigot_d = 27.8;          // spigot that enters the housing
spigot_h = 2;             // spigot height
shaft_d = 12.5;           // shaft opening
bolt_d = 6.6;             // bolt clearance
bolt_r = 17.95;           // bolt circle radius
dome_h = 4;               // raised centre

module cover() {
  cylinder(h = cover_t, d = cover_d);
}

module spigot() {
  /* sunk 1 mm into the cover; the spigot sets the overall height */
  translate([0, 0, -spigot_h]) cylinder(h = spigot_h + 1, d = spigot_d);
}

module dome() {
  translate([0, 0, cover_t - 1]) cylinder(h = dome_h + 1, d = cover_d * 0.55);
}

difference() {
  union() {
    cover();
    spigot();
    dome();
  }
  for (i = [0 : 3]) rotate([0, 0, 45 + i * 90]) translate([bolt_r, 0, -spigot_h - 1])
    cylinder(h = spigot_h + cover_t + 2, d = bolt_d);
  translate([0, 0, -spigot_h - 1]) cylinder(h = spigot_h + cover_t + 2, d = shaft_d);
}
