$fn = 32;

// ----------------------------------------------------------------------
// Bolt-circle flange: 70 mm outside, 5 bolt holes, bore 28 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
flange_d = 70;            // flange outside diameter
flange_t = 10;            // flange thickness
bolts = 5;                // number of bolt holes
bolt_d = 11;              // bolt clearance
bolt_r = 17.4;            // bolt circle radius
bore_d = 28;              // centre bore
spot_d = 17;              // spot faced bosses
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
