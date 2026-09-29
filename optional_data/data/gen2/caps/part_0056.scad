$fn = 32;

// ----------------------------------------------------------------------
// Retaining cap: 6202 cover, 47 mm, spigot 34.8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
cap_d = 47;               // cover diameter
cap_t = 6;                // cover thickness
lip_d = 34.8;             // spigot that enters the housing
lip_h = 3;                // spigot height
bolt_d = 6.6;             // bolt clearance
bolt_r = 20.45;           // bolt circle radius
nipple_d = 6;             // grease nipple boss
nipple_h = 5;             // grease nipple boss height

module cover() {
  cylinder(h = cap_t, d = cap_d);
}

module spigot() {
  /* sunk 1 mm into the cover; the spigot sets the overall height */
  translate([0, 0, -lip_h]) cylinder(h = lip_h + 1, d = lip_d);
}

module nipple() {
  translate([cap_d * 0.32, 0, cap_t - 1])
    cylinder(h = nipple_h + 1, d = nipple_d);
}

difference() {
  union() {
    cover();
    spigot();
    nipple();
  }
  for (i = [0 : 3]) rotate([0, 0, 45 + i * 90]) translate([bolt_r, 0, -lip_h - 1])
    cylinder(h = lip_h + cap_t + 2, d = bolt_d);
  translate([cap_d * 0.32, 0, cap_t + nipple_h - 1.5]) cylinder(h = 4, d = 3.4);
}
