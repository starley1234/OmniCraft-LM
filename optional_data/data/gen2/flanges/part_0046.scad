$fn = 32;

// ----------------------------------------------------------------------
// Bolt-circle flange: 70 mm outside, 8 bolt holes, bore 28 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
flange_d = 70;            // flange outside diameter
flange_t = 8;             // flange thickness
bolts = 8;                // number of bolt holes
bolt_d = 7;               // bolt clearance
bolt_r = 23.8;            // bolt circle radius
bore_d = 28;              // centre bore

module body() {
  cylinder(h = flange_t, d = flange_d);
}

difference() {
  body();
  /* bolt circle */
  for (i = [0 : bolts - 1]) rotate([0, 0, i * 360 / bolts]) translate([bolt_r, 0, -1]) cylinder(h = flange_t + 3, d = bolt_d);
  translate([0, 0, -1]) cylinder(h = flange_t + 3, d = bore_d);
}
