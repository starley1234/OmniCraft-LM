$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6203 (40 x 12 mm), 50.1 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
housing_d = 50.1;         // housing outside diameter
housing_h = 21.4;         // overall housing height
wall_t = 5;               // wall thickness
seat_d = 40.1;            // 6203 seat, 0.1 mm clearance
seat_h = 12.4;            // pocket depth
shoulder = 4;             // shoulder under the bearing
pass_d = 18;              // shaft passage
flange_d = 66.1;          // mounting flange diameter
flange_t = 5;             // flange thickness
bolt_d = 3.4;             // flange bolt clearance
bolt_r = 28.35;           // flange bolt circle radius

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
