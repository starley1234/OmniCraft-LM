$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6202 (35 x 11 mm), 43.25 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
housing_d = 43.25;        // housing outside diameter
housing_h = 16.4;         // overall housing height
wall_t = 4;               // wall thickness
seat_d = 35.25;           // 6202 seat, 0.25 mm clearance
seat_h = 11.4;            // pocket depth
shoulder = 5;             // shoulder under the bearing
pass_d = 15.3;            // shaft passage

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
