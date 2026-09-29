$fn = 32;

// ----------------------------------------------------------------------
// Bolt-circle flange: 180 mm outside, 4 bolt holes, bore 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
flange_d = 180;           // flange outside diameter
flange_t = 8;             // flange thickness
bolts = 4;                // number of bolt holes
bolt_d = 7;               // bolt clearance
bolt_r = 78.8;            // bolt circle radius
bore_d = 50;              // centre bore
hub_d = 64;               // raised hub diameter
hub_h = 15;               // raised hub height
groove_w = 3;             // gasket groove width
groove_d = 1.4;           // gasket groove depth
groove_r = 34;            // groove radius
groove_z = 6.6;           // groove floor depth from the face

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
