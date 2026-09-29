$fn = 32;

// ----------------------------------------------------------------------
// Retaining cap: 6002 cover, 48 mm, spigot 31.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
cover_d = 48;             // cover diameter
cover_t = 6;              // cover thickness
spigot_d = 31.7;          // spigot that enters the housing
spigot_h = 3;             // spigot height
shaft_d = 15.3;           // shaft opening
bolt_d = 3.4;             // bolt clearance
bolt_r = 19.93;           // bolt circle radius
dome_h = 3;               // raised centre

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
