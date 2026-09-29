$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6001 (28 x 8 mm), 34.15 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
housing_d = 34.15;        // housing outside diameter
housing_h = 12.4;         // overall housing height
wall_t = 3;               // wall thickness
seat_d = 28.15;           // 6001 seat, 0.15 mm clearance
seat_h = 8.4;             // pocket depth
shoulder = 4;             // shoulder under the bearing
pass_d = 12.5;            // shaft passage

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
