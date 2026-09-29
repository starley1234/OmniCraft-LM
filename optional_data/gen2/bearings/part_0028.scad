$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6204 (47 x 14 mm), 55.1 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
housing_d = 55.1;         // housing outside diameter
housing_h = 18.4;         // overall housing height
wall_t = 4;               // wall thickness
seat_d = 47.1;            // 6204 seat, 0.1 mm clearance
seat_h = 14.4;            // pocket depth
shoulder = 4;             // shoulder under the bearing
pass_d = 21;              // shaft passage

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
