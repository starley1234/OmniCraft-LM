$fn = 32;
// ----------------------------------------------------------------------
// Bearing housing: seat for 6000 (26 x 8 mm), 32.15 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
housing_d = 32.15;        // housing outside diameter
housing_h = 13.4;         // overall housing height
wall_t = 3;               // wall thickness
seat_d = 26.15;           // 6000 seat, 0.15 mm clearance
seat_h = 8.4;             // pocket depth
shoulder = 5;             // shoulder under the bearing
pass_d = 11;              // shaft passage

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
