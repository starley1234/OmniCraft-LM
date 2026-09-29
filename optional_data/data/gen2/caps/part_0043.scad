$fn = 32;

// ----------------------------------------------------------------------
// Retaining cap: 6203 cover, 56 mm, spigot 39.8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
cover_d = 56;             // cover diameter
cover_t = 6;              // cover thickness
spigot_d = 39.8;          // spigot that enters the housing
spigot_h = 5;             // spigot height
shaft_d = 17.3;           // shaft opening
bolt_d = 3.4;             // bolt clearance
bolt_r = 23.95;           // bolt circle radius

module cover() {
  cylinder(h = cover_t, d = cover_d);
}

module spigot() {
  /* sunk 1 mm into the cover; the spigot sets the overall height */
  translate([0, 0, -spigot_h]) cylinder(h = spigot_h + 1, d = spigot_d);
}

difference() {
  union() {
    cover();
    spigot();
  }
  for (i = [0 : 3]) rotate([0, 0, 45 + i * 90]) translate([bolt_r, 0, -spigot_h - 1])
    cylinder(h = spigot_h + cover_t + 2, d = bolt_d);
  translate([0, 0, -spigot_h - 1]) cylinder(h = spigot_h + cover_t + 2, d = shaft_d);
}
