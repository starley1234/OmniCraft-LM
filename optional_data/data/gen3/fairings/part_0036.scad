$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 58 x 30 mm, 4 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 58;               // channel width at mid length
height = 30;              // channel height at mid length
wall = 4;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 37.7;             // faired end width
end_h = 19.5;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -18.85, 0]) cube([0.4, 37.7, 19.5]);
      translate([18, -22.4, 0]) cube([0.4, 44.8, 23.18]);
    }
    hull() {
      translate([18, -22.4, 0]) cube([0.4, 44.8, 23.18]);
      translate([100, -29, 0]) cube([0.4, 58, 30]);
    }
    hull() {
      translate([100, -29, 0]) cube([0.4, 58, 30]);
      translate([182, -22.4, 0]) cube([0.4, 44.8, 23.18]);
    }
    hull() {
      translate([182, -22.4, 0]) cube([0.4, 44.8, 23.18]);
      translate([200, -18.85, 0]) cube([0.4, 37.7, 19.5]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -17.25, 4]) cube([0.4, 34.5, 13.9]);
    translate([13, -19.96, 4]) cube([0.4, 39.92, 16.73]);
  }
  hull() {
    translate([13, -19.96, 4]) cube([0.4, 39.92, 16.73]);
    translate([95, -25, 4]) cube([0.4, 50, 22]);
  }
  hull() {
    translate([95, -25, 4]) cube([0.4, 50, 22]);
    translate([177, -19.96, 4]) cube([0.4, 39.92, 16.73]);
  }
  hull() {
    translate([177, -19.96, 4]) cube([0.4, 39.92, 16.73]);
    translate([205, -17.25, 4]) cube([0.4, 34.5, 13.9]);
  }
}
