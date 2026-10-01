$fn = 32;

// ----------------------------------------------------------------------
// Hopper: funnel with square flange
// ----------------------------------------------------------------------

// --- parameters (mm) ---
fl = 80;                  // flange side, X and Y
fl_t = 10;                // flange thickness
cone_h = 60;              // cone height above the flange
top_d = 50;               // cone mouth diameter
bot_d = 20;               // cone spout diameter
wall = 2;                 // cone wall thickness
fit_tol = 0.02;           // tolerance for press fits, mm
free_tol = 0.2;           // tolerance for clearance fits, mm

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
}
