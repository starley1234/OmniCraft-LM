$fn = 32;

// ----------------------------------------------------------------------
// Bolt-circle flange: 100 mm outside, 5 bolt holes, bore 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
flange_d = 100;           // flange outside diameter
flange_t = 8;             // flange thickness
bolts = 5;                // number of bolt holes
bolt_d = 7;               // bolt clearance
bolt_r = 38.8;            // bolt circle radius
bore_d = 25;              // centre bore
spigot_d = 37;            // spigot diameter
spigot_h = 6;             // spigot height below the flange
sink = 1;                 // overlap into the flange
spot_d = 13;              // spot faced bosses
spot_h = 1.6;             // spot face height

module body() {
  cylinder(h = flange_t, d = flange_d);
  /* spigot on the back face, sunk into the flange */
  translate([0, 0, -spigot_h + sink]) cylinder(h = spigot_h, d = spigot_d);
  /* spot faced pads under the bolt heads */
  for (i = [0 : bolts - 1]) rotate([0, 0, i * 360 / bolts]) translate([bolt_r, 0, flange_t - 1]) cylinder(h = spot_h + 1, d = spot_d);
}

difference() {
  body();
  /* bolt circle */
  for (i = [0 : bolts - 1]) rotate([0, 0, i * 360 / bolts]) translate([bolt_r, 0, -spigot_h - 1]) cylinder(h = flange_t + spigot_h + 3, d = bolt_d);
  translate([0, 0, -spigot_h - 1]) cylinder(h = flange_t + spigot_h + 3, d = bore_d);
}
