$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6202 (35 x 11 mm), 41.2 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
housing_d = 41.2;         // housing outside diameter
housing_h = 16.4;         // overall housing height
wall_t = 3;               // wall thickness
seat_d = 35.2;            // 6202 seat, 0.2 mm clearance
seat_h = 11.4;            // pocket depth
shoulder = 5;             // shoulder under the bearing
pass_d = 17;              // shaft passage

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
