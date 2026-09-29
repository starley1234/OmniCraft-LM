$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 608 (22 x 7 mm), 30.25 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
body_od = 30.25;          // housing outside diameter
body_h = 18.4;            // overall housing height
wall = 4;                 // wall thickness
pocket_d = 22.25;         // 608 seat, 0.25 mm clearance
seat_h = 7.4;             // pocket depth
shoulder = 5;             // shoulder under the bearing
pass_d = 10;              // shaft passage
flange_dia = 42.25;       // mounting flange diameter
flange_t = 6;             // flange thickness
bolt_d = 5.5;             // flange bolt clearance
bolt_r = 15.38;           // flange bolt circle radius
rib_w = 5;                // rib width
rib_n = 4;                // rib count

module body() {
  cylinder(h = body_h, d = body_od);
}

module flange() {
  /* flange sunk 1.5 mm into the body */
  cylinder(h = flange_t + 1.5, d = flange_dia);
}

module ribs() {
  for (i = [0 : rib_n - 1])
    rotate([0, 0, i * 360 / rib_n])
      translate([-rib_w / 2, body_od / 2 - 0.8, flange_t - 1])
        cube([rib_w, (flange_dia - body_od) / 2 + 0.8, body_h - flange_t + 1]);
}

difference() {
  union() {
    body();
    flange();
    ribs();
  }
  translate([0, 0, body_h - seat_h]) cylinder(h = seat_h + 1, d = pocket_d);
  translate([0, 0, -1]) cylinder(h = body_h - seat_h + 1, d = pass_d);
  for (i = [0 : 3]) rotate([0, 0, 45 + i * 90]) translate([bolt_r, 0, -1])
    cylinder(h = flange_t + 3, d = bolt_d);
}
