$fn = 32;

// ----------------------------------------------------------------------
// Hopper: flanged with square flange
// ----------------------------------------------------------------------

// --- parameters (mm) ---
fl = 90;                  // flange side, X and Y
fl_t = 6;                 // flange thickness
cone_h = 50;              // cone height above the flange
top_d = 70;               // cone mouth diameter
bot_d = 28;               // cone spout diameter
wall = 2;                 // cone wall thickness
hole_r = 3;               // flange hole radius
hole_in = 8;              // hole inset from the corners

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
