$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 608 (22 x 7 mm), 32.25 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
housing_d = 32.25;        // housing outside diameter
housing_h = 11.4;         // overall housing height
wall_t = 5;               // wall thickness
seat_d = 22.25;           // 608 seat, 0.25 mm clearance
seat_h = 7.4;             // pocket depth
shoulder = 4;             // shoulder under the bearing
pass_d = 9;               // shaft passage

module body() {
  cylinder(h = housing_h, d = housing_d);
}

difference() {
  union() {
    body();
  }
  translate([0, 0, housing_h - seat_h]) cylinder(h = seat_h + 1, d = seat_d);
  translate([0, 0, -1]) cylinder(h = housing_h - seat_h + 1, d = pass_d);
}
