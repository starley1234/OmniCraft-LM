$fn = 32;

// ----------------------------------------------------------------------
// Bolt-circle flange: 120 mm outside, 8 bolt holes, bore 20 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
flange_d = 120;           // flange outside diameter
flange_t = 15;            // flange thickness
bolts = 8;                // number of bolt holes
bolt_d = 7;               // bolt clearance
bolt_r = 48.8;            // bolt circle radius
bore_d = 20;              // centre bore
spot_d = 13;              // spot faced bosses
spot_h = 1.6;             // spot face height

module body() {
  cylinder(h = flange_t, d = flange_d);
  /* spot faced pads under the bolt heads */
  for (i = [0 : bolts - 1]) rotate([0, 0, i * 360 / bolts]) translate([bolt_r, 0, flange_t - 1]) cylinder(h = spot_h + 1, d = spot_d);
}

difference() {
  body();
  /* bolt circle */
  for (i = [0 : bolts - 1]) rotate([0, 0, i * 360 / bolts]) translate([bolt_r, 0, -1]) cylinder(h = flange_t + 3, d = bolt_d);
  translate([0, 0, -1]) cylinder(h = flange_t + 3, d = bore_d);
}
