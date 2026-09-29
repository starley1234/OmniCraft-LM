$fn = 32;

// ----------------------------------------------------------------------
// Bolt-circle flange: 120 mm outside, 8 bolt holes, bore 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
flange_d = 120;           // flange outside diameter
flange_t = 6;             // flange thickness
bolts = 8;                // number of bolt holes
bolt_d = 13;              // bolt clearance
bolt_r = 39.2;            // bolt circle radius
bore_d = 25;              // centre bore
spigot_d = 37;            // spigot diameter
spigot_h = 3;             // spigot height below the flange
sink = 1;                 // overlap into the flange
groove_w = 3;             // gasket groove width
groove_d = 1.4;           // gasket groove depth
groove_r = 14.5;          // groove radius
groove_z = 4.6;           // groove floor depth from the face

module body() {
  cylinder(h = flange_t, d = flange_d);
  /* spigot on the back face, sunk into the flange */
  translate([0, 0, -spigot_h + sink]) cylinder(h = spigot_h, d = spigot_d);
}

difference() {
  body();
  /* bolt circle */
  for (i = [0 : bolts - 1]) rotate([0, 0, i * 360 / bolts]) translate([bolt_r, 0, -spigot_h - 1]) cylinder(h = flange_t + spigot_h + 3, d = bolt_d);
  translate([0, 0, -spigot_h - 1]) cylinder(h = flange_t + spigot_h + 3, d = bore_d);
  /* gasket groove on the front face */
  rotate_extrude() translate([groove_r, groove_z]) square([groove_w, groove_d + 1]);
}
