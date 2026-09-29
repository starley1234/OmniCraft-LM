$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6002 (32 x 9 mm), 44.2 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
case_d = 44.2;            // housing outside diameter
case_h = 13.4;            // overall housing height
rim_t = 6;                // wall thickness
bearing_seat = 32.2;      // 6002 seat, 0.2 mm clearance
seat_h = 9.4;             // pocket depth
shoulder = 4;             // shoulder under the bearing
pass_d = 15.3;            // shaft passage

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
