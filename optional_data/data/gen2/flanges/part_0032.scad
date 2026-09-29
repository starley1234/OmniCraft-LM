$fn = 32;

// ----------------------------------------------------------------------
// Bolt-circle flange: 180 mm outside, 8 bolt holes, bore 20 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
flange_d = 180;           // flange outside diameter
flange_t = 15;            // flange thickness
bolts = 8;                // number of bolt holes
bolt_d = 9;               // bolt clearance
bolt_r = 75.6;            // bolt circle radius
bore_d = 20;              // centre bore
spigot_d = 32;            // spigot diameter
spigot_h = 3;             // spigot height below the flange
sink = 1;                 // overlap into the flange
spot_d = 15;              // spot faced bosses
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
