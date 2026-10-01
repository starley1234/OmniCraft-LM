$fn = 32;

// ----------------------------------------------------------------------
// Hopper: funnel with square flange
// ----------------------------------------------------------------------

// --- parameters (mm) ---
fl = 90;                  // flange side, X and Y
fl_t = 6;                 // flange thickness
cone_h = 40;              // cone height above the flange
top_d = 60;               // cone mouth diameter
bot_d = 28;               // cone spout diameter
wall = 2.5;               // cone wall thickness

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
