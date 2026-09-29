$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 608 (22 x 7 mm), 32.1 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
case_d = 32.1;            // housing outside diameter
case_h = 15.4;            // overall housing height
rim_t = 5;                // wall thickness
bearing_seat = 22.1;      // 608 seat, 0.1 mm clearance
seat_h = 7.4;             // pocket depth
shoulder = 4;             // shoulder under the bearing
pass_d = 9;               // shaft passage
ear_d = 52.1;             // mounting flange diameter
flange_t = 4;             // flange thickness
bolt_d = 5.5;             // flange bolt clearance
bolt_r = 20.3;            // flange bolt circle radius

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
