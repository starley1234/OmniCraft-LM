$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 608 (22 x 7 mm), 34.25 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
body_od = 34.25;          // housing outside diameter
body_h = 17.4;            // overall housing height
wall = 6;                 // wall thickness
pocket_d = 22.25;         // 608 seat, 0.25 mm clearance
seat_h = 7.4;             // pocket depth
shoulder = 2;             // shoulder under the bearing
pass_d = 8.5;             // shaft passage
flange_dia = 60.25;       // mounting flange diameter
flange_t = 8;             // flange thickness
bolt_d = 4.5;             // flange bolt clearance
bolt_r = 24.88;           // flange bolt circle radius

module body() {
  cylinder(h = body_h, d = body_od);
}

module flange() {
  /* flange sunk 1.5 mm into the body */
  cylinder(h = flange_t + 1.5, d = flange_dia);
}

difference() {
  union() {
    body();
    flange();
  }
  translate([0, 0, body_h - seat_h]) cylinder(h = seat_h + 1, d = pocket_d);
  translate([0, 0, -1]) cylinder(h = body_h - seat_h + 1, d = pass_d);
  for (i = [0 : 3]) rotate([0, 0, 45 + i * 90]) translate([bolt_r, 0, -1])
    cylinder(h = flange_t + 3, d = bolt_d);
}
