$fn = 32;

// ----------------------------------------------------------------------
// Bolt-circle flange: 70 mm outside, 6 bolt holes, bore 28 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
flange_d = 70;            // flange outside diameter
flange_t = 12;            // flange thickness
bolts = 6;                // number of bolt holes
bolt_d = 6;               // bolt clearance
bolt_r = 25.4;            // bolt circle radius
bore_d = 28;              // centre bore
spigot_d = 40;            // spigot diameter
spigot_h = 3;             // spigot height below the flange
sink = 1;                 // overlap into the flange

module body() {
  cylinder(h = flange_t, d = flange_d);
  /* spigot on the back face, sunk into the flange */
  translate([0, 0, -spigot_h + sink]) cylinder(h = spigot_h, d = spigot_d);
}

difference() {
  body();
  /* bolt circle */
  for (i = [0 : bolts - 1]) rotate([0, 0, i * 360 / bolts]) translate([bolt_r, 0, -spigot_h - 1]) cylinder(h = flange_t + spigot_h + 3, d = bolt_d);
  translate([0, 0, -spigot_h - 1]) cylinder(h = flange_t + spigot_h + 3, d = bore_d);
}
