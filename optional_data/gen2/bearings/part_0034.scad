$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6203 (40 x 12 mm), 50.25 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
body_od = 50.25;          // housing outside diameter
body_h = 19.4;            // overall housing height
wall = 5;                 // wall thickness
pocket_d = 40.25;         // 6203 seat, 0.25 mm clearance
seat_h = 12.4;            // pocket depth
shoulder = 3;             // shoulder under the bearing
pass_d = 18;              // shaft passage
flange_dia = 66.25;       // mounting flange diameter
flange_t = 4;             // flange thickness
bolt_d = 4.5;             // flange bolt clearance
bolt_r = 27.88;           // flange bolt circle radius

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
