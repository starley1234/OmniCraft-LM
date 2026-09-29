$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6002 (32 x 9 mm), 44.1 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
body_od = 44.1;           // housing outside diameter
body_h = 12.4;            // overall housing height
wall = 6;                 // wall thickness
pocket_d = 32.1;          // 6002 seat, 0.1 mm clearance
seat_h = 9.4;             // pocket depth
shoulder = 3;             // shoulder under the bearing
pass_d = 16;              // shaft passage

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
