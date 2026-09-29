$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6000 (26 x 8 mm), 36.15 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
housing_d = 36.15;        // housing outside diameter
housing_h = 14.4;         // overall housing height
wall_t = 5;               // wall thickness
seat_d = 26.15;           // 6000 seat, 0.15 mm clearance
seat_h = 8.4;             // pocket depth
shoulder = 2;             // shoulder under the bearing
pass_d = 12;              // shaft passage
flange_d = 56.15;         // mounting flange diameter
flange_t = 4;             // flange thickness
bolt_d = 4.5;             // flange bolt clearance
bolt_r = 22.82;           // flange bolt circle radius
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
