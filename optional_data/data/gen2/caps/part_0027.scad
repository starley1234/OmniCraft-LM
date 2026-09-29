$fn = 32;

// ----------------------------------------------------------------------
// Retaining cap: 6202 cover, 59 mm, spigot 34.8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
cap_d = 59;               // cover diameter
cap_t = 6;                // cover thickness
lip_d = 34.8;             // spigot that enters the housing
lip_h = 5;                // spigot height
shaft_d = 16;             // shaft opening
bolt_d = 4.5;             // bolt clearance
bolt_r = 23.45;           // bolt circle radius
dome_h = 4;               // raised centre

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

difference() {
  union() {
    cover();
    spigot();
    dome();
  }
  for (i = [0 : 3]) rotate([0, 0, 45 + i * 90]) translate([bolt_r, 0, -lip_h - 1])
    cylinder(h = lip_h + cap_t + 2, d = bolt_d);
  translate([0, 0, -lip_h - 1]) cylinder(h = lip_h + cap_t + 2, d = shaft_d);
}
