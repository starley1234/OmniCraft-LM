$fn = 32;

// ----------------------------------------------------------------------
// Bolt-circle flange: 60 mm outside, 4 bolt holes, bore 24 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
flange_d = 60;            // flange outside diameter
flange_t = 15;            // flange thickness
bolts = 4;                // number of bolt holes
bolt_d = 6;               // bolt clearance
bolt_r = 20.4;            // bolt circle radius
bore_d = 24;              // centre bore
hub_d = 33;               // raised hub diameter
hub_h = 10;               // raised hub height
spigot_d = 36;            // spigot diameter
spigot_h = 4;             // spigot height below the flange
sink = 1;                 // overlap into the flange

module body() {
  cylinder(h = flange_t, d = flange_d);
  /* raised hub, sunk 1 mm into the flange */
  translate([0, 0, flange_t - 1]) cylinder(h = hub_h + 1, d = hub_d);
  /* spigot on the back face, sunk into the flange */
  translate([0, 0, -spigot_h + sink]) cylinder(h = spigot_h, d = spigot_d);
}

difference() {
  body();
  /* bolt circle */
  for (i = [0 : bolts - 1]) rotate([0, 0, i * 360 / bolts]) translate([bolt_r, 0, -spigot_h - 1]) cylinder(h = flange_t + hub_h + spigot_h + 3, d = bolt_d);
  translate([0, 0, -spigot_h - 1]) cylinder(h = flange_t + hub_h + spigot_h + 3, d = bore_d);
}
