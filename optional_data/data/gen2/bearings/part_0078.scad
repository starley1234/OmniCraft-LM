$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6202 (35 x 11 mm), 45.2 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
body_od = 45.2;           // housing outside diameter
body_h = 16.4;            // overall housing height
wall = 5;                 // wall thickness
pocket_d = 35.2;          // 6202 seat, 0.2 mm clearance
seat_h = 11.4;            // pocket depth
shoulder = 5;             // shoulder under the bearing
pass_d = 17;              // shaft passage

module body() {
  cylinder(h = body_h, d = body_od);
}

difference() {
  union() {
    body();
  }
  translate([0, 0, body_h - seat_h]) cylinder(h = seat_h + 1, d = pocket_d);
  translate([0, 0, -1]) cylinder(h = body_h - seat_h + 1, d = pass_d);
}
