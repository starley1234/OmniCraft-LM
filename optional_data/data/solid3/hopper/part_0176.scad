$fn = 32;

// ----------------------------------------------------------------------
// Hopper: flanged with square flange
// ----------------------------------------------------------------------

// --- parameters (mm) ---
fl = 110;                 // flange side, X and Y
fl_t = 10;                // flange thickness
cone_h = 50;              // cone height above the flange
top_d = 60;               // cone mouth diameter
bot_d = 20;               // cone spout diameter
wall = 2.5;               // cone wall thickness
hole_r = 2.5;             // flange hole radius
hole_in = 10;             // hole inset from the corners
fit_tol = 0.05;           // tolerance for press fits, mm
free_tol = 0.3;           // tolerance for clearance fits, mm

bore_d = bot_d - 2 * wall;  // spout bore diameter
total_h = fl_t + cone_h - 1;  // overall height

difference() {
  union() {
    cube([fl, fl, fl_t]);
    translate([fl / 2, fl / 2, fl_t - 1])
      cylinder(h = cone_h, d1 = bot_d, d2 = top_d);
  }
  translate([fl / 2, fl / 2, fl_t - 2])
    cylinder(h = cone_h + 1, d1 = bore_d, d2 = top_d - 2 * wall);
  for (sx = [0, 1], sy = [0, 1])
    translate([sx ? fl - hole_in : hole_in,
               sy ? fl - hole_in : hole_in, -1])
      cylinder(r = hole_r, h = fl_t + 2);
}
