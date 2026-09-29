$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6001 (28 x 8 mm), 34.15 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
housing_d = 34.15;        // housing outside diameter
housing_h = 15.4;         // overall housing height
wall_t = 3;               // wall thickness
seat_d = 28.15;           // 6001 seat, 0.15 mm clearance
seat_h = 8.4;             // pocket depth
shoulder = 3;             // shoulder under the bearing
pass_d = 13;              // shaft passage
flange_d = 54.15;         // mounting flange diameter
flange_t = 4;             // flange thickness
bolt_d = 5.5;             // flange bolt clearance
bolt_r = 21.32;           // flange bolt circle radius

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
