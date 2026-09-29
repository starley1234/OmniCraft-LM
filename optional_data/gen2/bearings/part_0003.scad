$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6000 (26 x 8 mm), 36.25 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
body_od = 36.25;          // housing outside diameter
body_h = 13.4;            // overall housing height
wall = 5;                 // wall thickness
pocket_d = 26.25;         // 6000 seat, 0.25 mm clearance
seat_h = 8.4;             // pocket depth
shoulder = 5;             // shoulder under the bearing
pass_d = 10.5;            // shaft passage

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
