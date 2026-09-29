$fn = 32;

// ----------------------------------------------------------------------
// Retaining cap: 608 cover, 42 mm, spigot 21.8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
cap_d = 42;               // cover diameter
cap_t = 8;                // cover thickness
lip_d = 21.8;             // spigot that enters the housing
lip_h = 5;                // spigot height
bolt_d = 6.6;             // bolt clearance
bolt_r = 15.95;           // bolt circle radius

module cover() {
  cylinder(h = cap_t, d = cap_d);
}

module spigot() {
  /* sunk 1 mm into the cover; the spigot sets the overall height */
  translate([0, 0, -lip_h]) cylinder(h = lip_h + 1, d = lip_d);
}

difference() {
  union() {
    cover();
    spigot();
  }
  for (i = [0 : 3]) rotate([0, 0, 45 + i * 90]) translate([bolt_r, 0, -lip_h - 1])
    cylinder(h = lip_h + cap_t + 2, d = bolt_d);
}
