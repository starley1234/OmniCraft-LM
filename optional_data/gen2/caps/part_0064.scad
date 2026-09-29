$fn = 32;

// ----------------------------------------------------------------------
// Retaining cap: 6202 cover, 51 mm, spigot 34.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
cover_d = 51;             // cover diameter
cover_t = 6;              // cover thickness
spigot_d = 34.7;          // spigot that enters the housing
spigot_h = 3;             // spigot height
shaft_d = 15.5;           // shaft opening
bolt_d = 3.4;             // bolt clearance
bolt_r = 21.43;           // bolt circle radius
nipple_d = 6;             // grease nipple boss
nipple_h = 5;             // grease nipple boss height

module cover() {
  cylinder(h = cover_t, d = cover_d);
}

module spigot() {
  /* sunk 1 mm into the cover; the spigot sets the overall height */
  translate([0, 0, -spigot_h]) cylinder(h = spigot_h + 1, d = spigot_d);
}

module nipple() {
  translate([cover_d * 0.32, 0, cover_t - 1])
    cylinder(h = nipple_h + 1, d = nipple_d);
}

difference() {
  union() {
    cover();
    spigot();
    nipple();
  }
  for (i = [0 : 3]) rotate([0, 0, 45 + i * 90]) translate([bolt_r, 0, -spigot_h - 1])
    cylinder(h = spigot_h + cover_t + 2, d = bolt_d);
  translate([0, 0, -spigot_h - 1]) cylinder(h = spigot_h + cover_t + 2, d = shaft_d);
  translate([cover_d * 0.32, 0, cover_t + nipple_h - 1.5]) cylinder(h = 4, d = 3.4);
}
