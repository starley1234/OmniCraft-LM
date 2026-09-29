$fn = 32;

// ----------------------------------------------------------------------
// Retaining cap: 6002 cover, 44 mm, spigot 31.8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
cap_d = 44;               // cover diameter
cap_t = 4;                // cover thickness
lip_d = 31.8;             // spigot that enters the housing
lip_h = 4;                // spigot height
shaft_d = 15.5;           // shaft opening
bolt_d = 5.5;             // bolt clearance
bolt_r = 18.95;           // bolt circle radius
dome_h = 3;               // raised centre
nipple_d = 6;             // grease nipple boss
nipple_h = 5;             // grease nipple boss height

module cover() {
  cylinder(h = cap_t, d = cap_d);
}

module spigot() {
  /* sunk 1 mm into the cover; the spigot sets the overall height */
  translate([0, 0, -lip_h]) cylinder(h = lip_h + 1, d = lip_d);
}

module dome() {
  translate([0, 0, cap_t - 1]) cylinder(h = dome_h + 1, d = cap_d * 0.55);
}

module nipple() {
  translate([cap_d * 0.32, 0, cap_t - 1])
    cylinder(h = nipple_h + 1, d = nipple_d);
}

difference() {
  union() {
    cover();
    spigot();
    dome();
    nipple();
  }
  for (i = [0 : 3]) rotate([0, 0, 45 + i * 90]) translate([bolt_r, 0, -lip_h - 1])
    cylinder(h = lip_h + cap_t + 2, d = bolt_d);
  translate([0, 0, -lip_h - 1]) cylinder(h = lip_h + cap_t + 2, d = shaft_d);
  translate([cap_d * 0.32, 0, cap_t + nipple_h - 1.5]) cylinder(h = 4, d = 3.4);
}
