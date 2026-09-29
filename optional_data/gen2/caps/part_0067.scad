$fn = 32;

// ----------------------------------------------------------------------
// Retaining cap: 6005 cover, 63 mm, spigot 46.6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
cap_d = 63;               // cover diameter
cap_t = 5;                // cover thickness
lip_d = 46.6;             // spigot that enters the housing
lip_h = 5;                // spigot height
shaft_d = 25.5;           // shaft opening
bolt_d = 3.4;             // bolt clearance
bolt_r = 27.4;            // bolt circle radius

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
