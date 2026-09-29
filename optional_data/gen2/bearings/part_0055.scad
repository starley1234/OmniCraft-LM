$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6002 (32 x 9 mm), 44.25 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
housing_d = 44.25;        // housing outside diameter
housing_h = 17.4;         // overall housing height
wall_t = 6;               // wall thickness
seat_d = 32.25;           // 6002 seat, 0.25 mm clearance
seat_h = 9.4;             // pocket depth
shoulder = 2;             // shoulder under the bearing
pass_d = 15.3;            // shaft passage
flange_d = 70.25;         // mounting flange diameter
flange_t = 6;             // flange thickness
bolt_d = 4.5;             // flange bolt clearance
bolt_r = 29.88;           // flange bolt circle radius
rib_w = 6;                // rib width
rib_n = 4;                // rib count

module body() {
  cylinder(h = housing_h, d = housing_d);
}

module flange() {
  /* flange sunk 1.5 mm into the body */
  cylinder(h = flange_t + 1.5, d = flange_d);
}

module ribs() {
  for (i = [0 : rib_n - 1])
    rotate([0, 0, i * 360 / rib_n])
      translate([-rib_w / 2, housing_d / 2 - 0.8, flange_t - 1])
        cube([rib_w, (flange_d - housing_d) / 2 + 0.8, housing_h - flange_t + 1]);
}

difference() {
  union() {
    body();
    flange();
    ribs();
  }
  translate([0, 0, housing_h - seat_h]) cylinder(h = seat_h + 1, d = seat_d);
  translate([0, 0, -1]) cylinder(h = housing_h - seat_h + 1, d = pass_d);
  for (i = [0 : 3]) rotate([0, 0, 45 + i * 90]) translate([bolt_r, 0, -1])
    cylinder(h = flange_t + 3, d = bolt_d);
}
