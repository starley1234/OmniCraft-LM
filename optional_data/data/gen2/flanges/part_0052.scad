$fn = 32;

// ----------------------------------------------------------------------
// Bolt-circle flange: 180 mm outside, 4 bolt holes, bore 30 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
flange_d = 180;           // flange outside diameter
flange_t = 12;            // flange thickness
bolts = 4;                // number of bolt holes
bolt_d = 7;               // bolt clearance
bolt_r = 78.8;            // bolt circle radius
bore_d = 30;              // centre bore
hub_d = 44;               // raised hub diameter
hub_h = 12;               // raised hub height
spot_d = 13;              // spot faced bosses
spot_h = 1.6;             // spot face height

module body() {
  cylinder(h = flange_t, d = flange_d);
  /* raised hub, sunk 1 mm into the flange */
  translate([0, 0, flange_t - 1]) cylinder(h = hub_h + 1, d = hub_d);
  /* spot faced pads under the bolt heads */
  for (i = [0 : bolts - 1]) rotate([0, 0, i * 360 / bolts]) translate([bolt_r, 0, flange_t - 1]) cylinder(h = spot_h + 1, d = spot_d);
}

difference() {
  body();
  /* bolt circle */
  for (i = [0 : bolts - 1]) rotate([0, 0, i * 360 / bolts]) translate([bolt_r, 0, -1]) cylinder(h = flange_t + hub_h + 3, d = bolt_d);
  translate([0, 0, -1]) cylinder(h = flange_t + hub_h + 3, d = bore_d);
}
