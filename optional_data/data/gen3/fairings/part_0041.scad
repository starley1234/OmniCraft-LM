$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 40 x 36 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 40;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 3;              // floor thickness
end_w = 24;               // faired end width
end_h = 21.6;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -12, 0]) cube([0.4, 24, 21.6]);
      translate([18, -14.8, 0]) cube([0.4, 29.6, 26.64]);
    }
    hull() {
      translate([18, -14.8, 0]) cube([0.4, 29.6, 26.64]);
      translate([100, -20, 0]) cube([0.4, 40, 36]);
    }
    hull() {
      translate([100, -20, 0]) cube([0.4, 40, 36]);
      translate([182, -14.8, 0]) cube([0.4, 29.6, 26.64]);
    }
    hull() {
      translate([182, -14.8, 0]) cube([0.4, 29.6, 26.64]);
      translate([200, -12, 0]) cube([0.4, 24, 21.6]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -10.4, 3]) cube([0.4, 20.8, 17]);
    translate([13, -12.535, 3]) cube([0.4, 25.07, 21.38]);
  }
  hull() {
    translate([13, -12.535, 3]) cube([0.4, 25.07, 21.38]);
    translate([95, -16.5, 3]) cube([0.4, 33, 29.5]);
  }
  hull() {
    translate([95, -16.5, 3]) cube([0.4, 33, 29.5]);
    translate([177, -12.535, 3]) cube([0.4, 25.07, 21.38]);
  }
  hull() {
    translate([177, -12.535, 3]) cube([0.4, 25.07, 21.38]);
    translate([205, -10.4, 3]) cube([0.4, 20.8, 17]);
  }
}
