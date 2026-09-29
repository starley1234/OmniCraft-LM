$fn = 32;

// ----------------------------------------------------------------------
// Retaining cap: 6202 cover, 59 mm, spigot 34.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_d = 59;             // cover diameter
plate_t = 8;              // cover thickness
boss_d = 34.7;            // spigot that enters the housing
boss_h = 4;               // spigot height
bolt_d = 4.5;             // bolt clearance
bolt_r = 23.43;           // bolt circle radius
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
