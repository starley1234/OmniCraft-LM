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
end_w = 24;               // faired end width
end_h = 25.2;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -12, 0]) cube([0.4, 24, 25.2]);
      translate([18, -14.8, 0]) cube([0.4, 29.6, 31.08]);
    }
    hull() {
      translate([18, -14.8, 0]) cube([0.4, 29.6, 31.08]);
      translate([100, -20, 0]) cube([0.4, 40, 42]);
    }
    hull() {
      translate([100, -20, 0]) cube([0.4, 40, 42]);
      translate([182, -14.8, 0]) cube([0.4, 29.6, 31.08]);
    }
    hull() {
      translate([182, -14.8, 0]) cube([0.4, 29.6, 31.08]);
      translate([200, -12, 0]) cube([0.4, 24, 25.2]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -10.4, 4]) cube([0.4, 20.8, 19.6]);
    translate([13, -12.71, 4]) cube([0.4, 25.42, 24.99]);
  }
  hull() {
    translate([13, -12.71, 4]) cube([0.4, 25.42, 24.99]);
    translate([95, -17, 4]) cube([0.4, 34, 35]);
  }
  hull() {
    translate([95, -17, 4]) cube([0.4, 34, 35]);
    translate([177, -12.71, 4]) cube([0.4, 25.42, 24.99]);
  }
  hull() {
    translate([177, -12.71, 4]) cube([0.4, 25.42, 24.99]);
    translate([205, -10.4, 4]) cube([0.4, 20.8, 19.6]);
  }
}
