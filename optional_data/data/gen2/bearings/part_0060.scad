$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6000 (26 x 8 mm), 38.15 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
case_d = 38.15;           // housing outside diameter
case_h = 20.4;            // overall housing height
rim_t = 6;                // wall thickness
bearing_seat = 26.15;     // 6000 seat, 0.15 mm clearance
seat_h = 8.4;             // pocket depth
shoulder = 4;             // shoulder under the bearing
pass_d = 11;              // shaft passage
ear_d = 58.15;            // mounting flange diameter
flange_t = 8;             // flange thickness
bolt_d = 5.5;             // flange bolt clearance
bolt_r = 23.32;           // flange bolt circle radius
rib_w = 4;                // rib width
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
