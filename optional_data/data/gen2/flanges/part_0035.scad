$fn = 32;

// ----------------------------------------------------------------------
// Bolt-circle flange: 100 mm outside, 5 bolt holes, bore 30 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
flange_d = 100;           // flange outside diameter
flange_t = 12;            // flange thickness
bolts = 5;                // number of bolt holes
bolt_d = 7;               // bolt clearance
bolt_r = 38.8;            // bolt circle radius
bore_d = 30;              // centre bore
spigot_d = 42;            // spigot diameter
spigot_h = 4;             // spigot height below the flange
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
