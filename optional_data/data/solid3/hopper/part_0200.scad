$fn = 32;

// ----------------------------------------------------------------------
// Hopper: funnel with square flange
// ----------------------------------------------------------------------

// --- parameters (mm) ---
fl = 80;                  // flange side, X and Y
fl_t = 8;                 // flange thickness
cone_h = 50;              // cone height above the flange
top_d = 70;               // cone mouth diameter
bot_d = 24;               // cone spout diameter
wall = 3;                 // cone wall thickness

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
