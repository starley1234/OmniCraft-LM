$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6204 (47 x 14 mm), 59.15 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
case_d = 59.15;           // housing outside diameter
case_h = 20.4;            // overall housing height
rim_t = 6;                // wall thickness
bearing_seat = 47.15;     // 6204 seat, 0.15 mm clearance
seat_h = 14.4;            // pocket depth
shoulder = 2;             // shoulder under the bearing
pass_d = 22;              // shaft passage
ear_d = 71.15;            // mounting flange diameter
flange_t = 4;             // flange thickness
bolt_d = 5.5;             // flange bolt clearance
bolt_r = 29.83;           // flange bolt circle radius

module body() {
  cylinder(h = case_h, d = case_d);
}

module flange() {
  /* flange sunk 1.5 mm into the body */
  cylinder(h = flange_t + 1.5, d = ear_d);
}

difference() {
  union() {
    body();
    flange();
  }
  translate([0, 0, case_h - seat_h]) cylinder(h = seat_h + 1, d = bearing_seat);
  translate([0, 0, -1]) cylinder(h = case_h - seat_h + 1, d = pass_d);
  for (i = [0 : 3]) rotate([0, 0, 45 + i * 90]) translate([bolt_r, 0, -1])
    cylinder(h = flange_t + 3, d = bolt_d);
}
