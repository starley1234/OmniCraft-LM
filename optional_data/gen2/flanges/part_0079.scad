$fn = 32;

// ----------------------------------------------------------------------
// Bolt-circle flange: 100 mm outside, 5 bolt holes, bore 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
flange_d = 100;           // flange outside diameter
flange_t = 12;            // flange thickness
bolts = 5;                // number of bolt holes
bolt_d = 13;              // bolt clearance
bolt_r = 29.2;            // bolt circle radius
bore_d = 25;              // centre bore
hub_d = 39;               // raised hub diameter
hub_h = 20;               // raised hub height

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
