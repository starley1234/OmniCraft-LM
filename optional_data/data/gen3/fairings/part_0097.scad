$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 40 x 42 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 40;               // channel width at mid length
height = 42;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 28;               // faired end width
end_h = 29.4;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -14, 0]) cube([0.4, 28, 29.4]);
      translate([18, -16.1, 0]) cube([0.4, 32.2, 33.81]);
    }
    hull() {
      translate([18, -16.1, 0]) cube([0.4, 32.2, 33.81]);
      translate([100, -20, 0]) cube([0.4, 40, 42]);
    }
    hull() {
      translate([100, -20, 0]) cube([0.4, 40, 42]);
      translate([182, -16.1, 0]) cube([0.4, 32.2, 33.81]);
    }
    hull() {
      translate([182, -16.1, 0]) cube([0.4, 32.2, 33.81]);
      translate([200, -14, 0]) cube([0.4, 28, 29.4]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -12.4, 4]) cube([0.4, 24.8, 23.8]);
    translate([13, -14.01, 4]) cube([0.4, 28.02, 27.72]);
  }
  hull() {
    translate([13, -14.01, 4]) cube([0.4, 28.02, 27.72]);
    translate([95, -17, 4]) cube([0.4, 34, 35]);
  }
  hull() {
    translate([95, -17, 4]) cube([0.4, 34, 35]);
    translate([177, -14.01, 4]) cube([0.4, 28.02, 27.72]);
  }
  hull() {
    translate([177, -14.01, 4]) cube([0.4, 28.02, 27.72]);
    translate([205, -12.4, 4]) cube([0.4, 24.8, 23.8]);
  }
}
