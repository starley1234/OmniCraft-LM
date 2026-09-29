$fn = 32;

// ----------------------------------------------------------------------
// Retaining cap: 6202 cover, 51 mm, spigot 34.9 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
cover_d = 51;             // cover diameter
cover_t = 8;              // cover thickness
spigot_d = 34.9;          // spigot that enters the housing
spigot_h = 5;             // spigot height
shaft_d = 15.3;           // shaft opening
bolt_d = 4.5;             // bolt clearance
bolt_r = 21.48;           // bolt circle radius

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
