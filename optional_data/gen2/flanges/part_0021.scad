$fn = 32;

// ----------------------------------------------------------------------
// Bolt-circle flange: 100 mm outside, 5 bolt holes, bore 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
flange_d = 100;           // flange outside diameter
flange_t = 10;            // flange thickness
bolts = 5;                // number of bolt holes
bolt_d = 11;              // bolt clearance
bolt_r = 32.4;            // bolt circle radius
bore_d = 40;              // centre bore
hub_d = 54;               // raised hub diameter
hub_h = 15;               // raised hub height

module body() {
  cylinder(h = flange_t, d = flange_d);
  /* raised hub, sunk 1 mm into the flange */
  translate([0, 0, flange_t - 1]) cylinder(h = hub_h + 1, d = hub_d);
}

difference() {
  body();
  /* bolt circle */
  for (i = [0 : bolts - 1]) rotate([0, 0, i * 360 / bolts]) translate([bolt_r, 0, -1]) cylinder(h = flange_t + hub_h + 3, d = bolt_d);
  translate([0, 0, -1]) cylinder(h = flange_t + hub_h + 3, d = bore_d);
}
