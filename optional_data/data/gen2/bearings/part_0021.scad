$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6204 (47 x 14 mm), 53.2 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
case_d = 53.2;            // housing outside diameter
case_h = 16.4;            // overall housing height
rim_t = 3;                // wall thickness
bearing_seat = 47.2;      // 6204 seat, 0.2 mm clearance
seat_h = 14.4;            // pocket depth
shoulder = 2;             // shoulder under the bearing
pass_d = 21;              // shaft passage

module body() {
  cylinder(h = case_h, d = case_d);
}

difference() {
  union() {
    body();
  }
  translate([0, 0, case_h - seat_h]) cylinder(h = seat_h + 1, d = bearing_seat);
  translate([0, 0, -1]) cylinder(h = case_h - seat_h + 1, d = pass_d);
}
