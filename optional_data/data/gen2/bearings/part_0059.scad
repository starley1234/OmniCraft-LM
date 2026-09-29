$fn = 32;

// ----------------------------------------------------------------------
// Bearing housing: seat for 6203 (40 x 12 mm), 52.15 mm body
// ----------------------------------------------------------------------

// --- parameters (mm) ---
body_od = 52.15;          // housing outside diameter
body_h = 20.4;            // overall housing height
wall = 6;                 // wall thickness
pocket_d = 40.15;         // 6203 seat, 0.15 mm clearance
seat_h = 12.4;            // pocket depth
shoulder = 4;             // shoulder under the bearing
pass_d = 17.3;            // shaft passage
flange_dia = 72.15;       // mounting flange diameter
flange_t = 4;             // flange thickness
bolt_d = 5.5;             // flange bolt clearance
bolt_r = 30.33;           // flange bolt circle radius
rib_w = 6;                // rib width
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
