$fn = 32;

// ----------------------------------------------------------------------
// Bolt-circle flange: 80 mm outside, 4 bolt holes, bore 32 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
flange_d = 80;            // flange outside diameter
flange_t = 10;            // flange thickness
bolts = 4;                // number of bolt holes
bolt_d = 13;              // bolt clearance
bolt_r = 19.2;            // bolt circle radius
bore_d = 32;              // centre bore

module body() {
  cylinder(h = flange_t, d = flange_d);
}

difference() {
  body();
  /* bolt circle */
  for (i = [0 : bolts - 1]) rotate([0, 0, i * 360 / bolts]) translate([bolt_r, 0, -1]) cylinder(h = flange_t + 3, d = bolt_d);
  translate([0, 0, -1]) cylinder(h = flange_t + 3, d = bore_d);
}
