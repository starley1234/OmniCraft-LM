$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 52 x 42 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 52;               // channel width at mid length
height = 42;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 4;              // floor thickness
end_w = 36.4;             // faired end width
end_h = 29.4;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -18.2, 0]) cube([0.4, 36.4, 29.4]);
      translate([18, -20.93, 0]) cube([0.4, 41.86, 33.81]);
    }
    hull() {
      translate([18, -20.93, 0]) cube([0.4, 41.86, 33.81]);
      translate([100, -26, 0]) cube([0.4, 52, 42]);
    }
    hull() {
      translate([100, -26, 0]) cube([0.4, 52, 42]);
      translate([182, -20.93, 0]) cube([0.4, 41.86, 33.81]);
    }
    hull() {
      translate([182, -20.93, 0]) cube([0.4, 41.86, 33.81]);
      translate([200, -18.2, 0]) cube([0.4, 36.4, 29.4]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -16.6, 4]) cube([0.4, 33.2, 23.8]);
    translate([13, -18.665, 4]) cube([0.4, 37.33, 27.55]);
  }
  hull() {
    translate([13, -18.665, 4]) cube([0.4, 37.33, 27.55]);
    translate([95, -22.5, 4]) cube([0.4, 45, 34.5]);
  }
  hull() {
    translate([95, -22.5, 4]) cube([0.4, 45, 34.5]);
    translate([177, -18.665, 4]) cube([0.4, 37.33, 27.55]);
  }
  hull() {
    translate([177, -18.665, 4]) cube([0.4, 37.33, 27.55]);
    translate([205, -16.6, 4]) cube([0.4, 33.2, 23.8]);
  }
}
