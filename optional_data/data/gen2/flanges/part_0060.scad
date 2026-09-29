$fn = 32;

// ----------------------------------------------------------------------
// Bolt-circle flange: 180 mm outside, 4 bolt holes, bore 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
flange_d = 180;           // flange outside diameter
flange_t = 10;            // flange thickness
bolts = 4;                // number of bolt holes
bolt_d = 11;              // bolt clearance
bolt_r = 72.4;            // bolt circle radius
bore_d = 40;              // centre bore
groove_w = 2.5;           // gasket groove width
groove_d = 1.4;           // gasket groove depth
groove_r = 22;            // groove radius
groove_z = 8.6;           // groove floor depth from the face

module body() {
  cylinder(h = flange_t, d = flange_d);
}

difference() {
  body();
  /* bolt circle */
  for (i = [0 : bolts - 1]) rotate([0, 0, i * 360 / bolts]) translate([bolt_r, 0, -1]) cylinder(h = flange_t + 3, d = bolt_d);
  translate([0, 0, -1]) cylinder(h = flange_t + 3, d = bore_d);
  /* gasket groove on the front face */
  rotate_extrude() translate([groove_r, groove_z]) square([groove_w, groove_d + 1]);
}
