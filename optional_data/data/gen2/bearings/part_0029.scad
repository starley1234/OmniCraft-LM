$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6202 (35 x 11 mm), 41.1 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
case_d = 41.1;            // housing outside diameter
case_h = 21.4;            // overall housing height
rim_t = 3;                // wall thickness
bearing_seat = 35.1;      // 6202 seat, 0.1 mm clearance
seat_h = 11.4;            // pocket depth
shoulder = 4;             // shoulder under the bearing
pass_d = 15.3;            // shaft passage
ear_d = 57.1;             // mounting flange diameter
flange_t = 6;             // flange thickness
bolt_d = 5.5;             // flange bolt clearance
bolt_r = 22.8;            // flange bolt circle radius
rib_w = 5;                // rib width
rib_n = 4;                // rib count

module body() {
  cylinder(h = case_h, d = case_d);
}

module flange() {
  /* flange sunk 1.5 mm into the body */
  cylinder(h = flange_t + 1.5, d = ear_d);
}

module ribs() {
  for (i = [0 : rib_n - 1])
    rotate([0, 0, i * 360 / rib_n])
      translate([-rib_w / 2, case_d / 2 - 0.8, flange_t - 1])
        cube([rib_w, (ear_d - case_d) / 2 + 0.8, case_h - flange_t + 1]);
}

difference() {
  union() {
    body();
    flange();
    ribs();
  }
  translate([0, 0, case_h - seat_h]) cylinder(h = seat_h + 1, d = bearing_seat);
  translate([0, 0, -1]) cylinder(h = case_h - seat_h + 1, d = pass_d);
  for (i = [0 : 3]) rotate([0, 0, 45 + i * 90]) translate([bolt_r, 0, -1])
    cylinder(h = flange_t + 3, d = bolt_d);
}
