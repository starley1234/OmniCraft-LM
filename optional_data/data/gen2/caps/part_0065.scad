$fn = 32;

// ----------------------------------------------------------------------
// Retaining cap: 6001 cover, 40 mm, spigot 27.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
cover_d = 40;             // cover diameter
cover_t = 4;              // cover thickness
spigot_d = 27.7;          // spigot that enters the housing
spigot_h = 5;             // spigot height
bolt_d = 3.4;             // bolt clearance
bolt_r = 16.93;           // bolt circle radius

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
}
