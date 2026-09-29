$fn = 32;

// ----------------------------------------------------------------------
// Retaining cap: 6001 cover, 48 mm, spigot 27.8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_d = 48;             // cover diameter
plate_t = 6;              // cover thickness
boss_d = 27.8;            // spigot that enters the housing
boss_h = 2;               // spigot height
bolt_d = 3.4;             // bolt clearance
bolt_r = 18.95;           // bolt circle radius
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
  translate([plate_d * 0.32, 0, plate_t + nipple_h - 1.5]) cylinder(h = 4, d = 3.4);
}
