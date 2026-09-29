$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6204 (47 x 14 mm), 57.2 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
housing_d = 57.2;         // housing outside diameter
housing_h = 25.4;         // overall housing height
wall_t = 5;               // wall thickness
seat_d = 47.2;            // 6204 seat, 0.2 mm clearance
seat_h = 14.4;            // pocket depth
shoulder = 3;             // shoulder under the bearing
pass_d = 20.3;            // shaft passage
flange_d = 73.2;          // mounting flange diameter
flange_t = 8;             // flange thickness
bolt_d = 4.5;             // flange bolt clearance
bolt_r = 31.35;           // flange bolt circle radius

module body() {
  cylinder(h = housing_h, d = housing_d);
}

module flange() {
  /* flange sunk 1.5 mm into the body */
  cylinder(h = flange_t + 1.5, d = flange_d);
}

difference() {
  union() {
    body();
    flange();
  }
  translate([0, 0, housing_h - seat_h]) cylinder(h = seat_h + 1, d = seat_d);
  translate([0, 0, -1]) cylinder(h = housing_h - seat_h + 1, d = pass_d);
  for (i = [0 : 3]) rotate([0, 0, 45 + i * 90]) translate([bolt_r, 0, -1])
    cylinder(h = flange_t + 3, d = bolt_d);
}
