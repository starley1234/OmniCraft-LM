$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6202 (35 x 11 mm), 45.1 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
case_d = 45.1;            // housing outside diameter
case_h = 15.4;            // overall housing height
rim_t = 5;                // wall thickness
bearing_seat = 35.1;      // 6202 seat, 0.1 mm clearance
seat_h = 11.4;            // pocket depth
shoulder = 4;             // shoulder under the bearing
pass_d = 15.5;            // shaft passage

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
