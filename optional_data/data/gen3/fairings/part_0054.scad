$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 58 x 42 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 58;               // channel width at mid length
height = 42;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 37.7;             // faired end width
end_h = 27.3;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -18.85, 0]) cube([0.4, 37.7, 27.3]);
      translate([18, -22.4, 0]) cube([0.4, 44.8, 32.45]);
    }
    hull() {
      translate([18, -22.4, 0]) cube([0.4, 44.8, 32.45]);
      translate([100, -29, 0]) cube([0.4, 58, 42]);
    }
    hull() {
      translate([100, -29, 0]) cube([0.4, 58, 42]);
      translate([182, -22.4, 0]) cube([0.4, 44.8, 32.45]);
    }
    hull() {
      translate([182, -22.4, 0]) cube([0.4, 44.8, 32.45]);
      translate([200, -18.85, 0]) cube([0.4, 37.7, 27.3]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -17.25, 4]) cube([0.4, 34.5, 21.7]);
    translate([13, -20.31, 4]) cube([0.4, 40.62, 26.36]);
  }
  hull() {
    translate([13, -20.31, 4]) cube([0.4, 40.62, 26.36]);
    translate([95, -26, 4]) cube([0.4, 52, 35]);
  }
  hull() {
    translate([95, -26, 4]) cube([0.4, 52, 35]);
    translate([177, -20.31, 4]) cube([0.4, 40.62, 26.36]);
  }
  hull() {
    translate([177, -20.31, 4]) cube([0.4, 40.62, 26.36]);
    translate([205, -17.25, 4]) cube([0.4, 34.5, 21.7]);
  }
}
