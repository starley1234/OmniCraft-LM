$fn = 32;

// ----------------------------------------------------------------------
// Bolt-circle flange: 100 mm outside, 6 bolt holes, bore 20 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
flange_d = 100;           // flange outside diameter
flange_t = 12;            // flange thickness
bolts = 6;                // number of bolt holes
bolt_d = 9;               // bolt clearance
bolt_r = 35.6;            // bolt circle radius
bore_d = 20;              // centre bore
hub_d = 34;               // raised hub diameter
hub_h = 20;               // raised hub height
groove_w = 4;             // gasket groove width
groove_d = 1.4;           // gasket groove depth
groove_r = 19;            // groove radius
groove_z = 10.6;          // groove floor depth from the face

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
  /* gasket groove on the front face */
  rotate_extrude() translate([groove_r, groove_z]) square([groove_w, groove_d + 1]);
}
