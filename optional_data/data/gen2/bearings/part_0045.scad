$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6002 (32 x 9 mm), 44.15 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
housing_d = 44.15;        // housing outside diameter
housing_h = 16.4;         // overall housing height
wall_t = 6;               // wall thickness
seat_d = 32.15;           // 6002 seat, 0.15 mm clearance
seat_h = 9.4;             // pocket depth
shoulder = 3;             // shoulder under the bearing
pass_d = 15.5;            // shaft passage
flange_d = 70.15;         // mounting flange diameter
flange_t = 4;             // flange thickness
bolt_d = 4.5;             // flange bolt clearance
bolt_r = 29.83;           // flange bolt circle radius

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
