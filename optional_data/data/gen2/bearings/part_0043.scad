$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6202 (35 x 11 mm), 47.25 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
case_d = 47.25;           // housing outside diameter
case_h = 20.4;            // overall housing height
rim_t = 6;                // wall thickness
bearing_seat = 35.25;     // 6202 seat, 0.25 mm clearance
seat_h = 11.4;            // pocket depth
shoulder = 3;             // shoulder under the bearing
pass_d = 16;              // shaft passage
ear_d = 59.25;            // mounting flange diameter
flange_t = 6;             // flange thickness
bolt_d = 4.5;             // flange bolt clearance
bolt_r = 24.38;           // flange bolt circle radius

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
