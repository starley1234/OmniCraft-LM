$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6203 (40 x 12 mm), 52.2 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
housing_d = 52.2;         // housing outside diameter
housing_h = 20.4;         // overall housing height
wall_t = 6;               // wall thickness
seat_d = 40.2;            // 6203 seat, 0.2 mm clearance
seat_h = 12.4;            // pocket depth
shoulder = 3;             // shoulder under the bearing
pass_d = 18;              // shaft passage
flange_d = 78.2;          // mounting flange diameter
flange_t = 5;             // flange thickness
bolt_d = 4.5;             // flange bolt clearance
bolt_r = 33.85;           // flange bolt circle radius

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
