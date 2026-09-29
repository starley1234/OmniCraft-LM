$fn = 32;

// ----------------------------------------------------------------------
// Retaining cap: 6002 cover, 48 mm, spigot 31.6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
cap_d = 48;               // cover diameter
cap_t = 5;                // cover thickness
lip_d = 31.6;             // spigot that enters the housing
lip_h = 4;                // spigot height
shaft_d = 15.3;           // shaft opening
bolt_d = 5.5;             // bolt clearance
bolt_r = 19.9;            // bolt circle radius

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
