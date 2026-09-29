$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6002 (32 x 9 mm), 42.15 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
housing_d = 42.15;        // housing outside diameter
housing_h = 20.4;         // overall housing height
wall_t = 5;               // wall thickness
seat_d = 32.15;           // 6002 seat, 0.15 mm clearance
seat_h = 9.4;             // pocket depth
shoulder = 5;             // shoulder under the bearing
pass_d = 16;              // shaft passage
flange_d = 68.15;         // mounting flange diameter
flange_t = 6;             // flange thickness
bolt_d = 3.4;             // flange bolt clearance
bolt_r = 29.38;           // flange bolt circle radius

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
