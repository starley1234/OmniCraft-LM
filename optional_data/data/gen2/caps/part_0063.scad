$fn = 32;

// ----------------------------------------------------------------------
// Retaining cap: 6001 cover, 44 mm, spigot 27.8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
cap_d = 44;               // cover diameter
cap_t = 6;                // cover thickness
lip_d = 27.8;             // spigot that enters the housing
lip_h = 5;                // spigot height
shaft_d = 13;             // shaft opening
bolt_d = 5.5;             // bolt clearance
bolt_r = 17.95;           // bolt circle radius

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
  translate([0, 0, -lip_h - 1]) cylinder(h = lip_h + cap_t + 2, d = shaft_d);
}
