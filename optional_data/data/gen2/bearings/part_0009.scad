$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6204 (47 x 14 mm), 59.2 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
body_od = 59.2;           // housing outside diameter
body_h = 18.4;            // overall housing height
wall = 6;                 // wall thickness
pocket_d = 47.2;          // 6204 seat, 0.2 mm clearance
seat_h = 14.4;            // pocket depth
shoulder = 4;             // shoulder under the bearing
pass_d = 22;              // shaft passage

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
