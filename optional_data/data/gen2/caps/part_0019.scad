$fn = 32;

// ----------------------------------------------------------------------
// Retaining cap: 6002 cover, 56 mm, spigot 31.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_d = 56;             // cover diameter
plate_t = 8;              // cover thickness
boss_d = 31.7;            // spigot that enters the housing
boss_h = 3;               // spigot height
shaft_d = 15.5;           // shaft opening
bolt_d = 6.6;             // bolt clearance
bolt_r = 21.93;           // bolt circle radius
nipple_d = 6;             // grease nipple boss
nipple_h = 5;             // grease nipple boss height

module cover() {
  cylinder(h = plate_t, d = plate_d);
}

module spigot() {
  /* sunk 1 mm into the cover; the spigot sets the overall height */
  translate([0, 0, -boss_h]) cylinder(h = boss_h + 1, d = boss_d);
}

module nipple() {
  translate([plate_d * 0.32, 0, plate_t - 1])
    cylinder(h = nipple_h + 1, d = nipple_d);
}

difference() {
  union() {
    cover();
    spigot();
    nipple();
  }
  for (i = [0 : 3]) rotate([0, 0, 45 + i * 90]) translate([bolt_r, 0, -boss_h - 1])
    cylinder(h = boss_h + plate_t + 2, d = bolt_d);
  translate([0, 0, -boss_h - 1]) cylinder(h = boss_h + plate_t + 2, d = shaft_d);
  translate([plate_d * 0.32, 0, plate_t + nipple_h - 1.5]) cylinder(h = 4, d = 3.4);
}
