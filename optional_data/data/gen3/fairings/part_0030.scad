$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 52 x 36 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 52;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 3;              // floor thickness
end_w = 36.4;             // faired end width
end_h = 25.2;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -18.2, 0]) cube([0.4, 36.4, 25.2]);
      translate([18, -20.93, 0]) cube([0.4, 41.86, 28.98]);
    }
    hull() {
      translate([18, -20.93, 0]) cube([0.4, 41.86, 28.98]);
      translate([100, -26, 0]) cube([0.4, 52, 36]);
    }
    hull() {
      translate([100, -26, 0]) cube([0.4, 52, 36]);
      translate([182, -20.93, 0]) cube([0.4, 41.86, 28.98]);
    }
    hull() {
      translate([182, -20.93, 0]) cube([0.4, 41.86, 28.98]);
      translate([200, -18.2, 0]) cube([0.4, 36.4, 25.2]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -16.6, 3]) cube([0.4, 33.2, 20.6]);
    translate([13, -18.665, 3]) cube([0.4, 37.33, 23.71]);
  }
  hull() {
    translate([13, -18.665, 3]) cube([0.4, 37.33, 23.71]);
    translate([95, -22.5, 3]) cube([0.4, 45, 29.5]);
  }
  hull() {
    translate([95, -22.5, 3]) cube([0.4, 45, 29.5]);
    translate([177, -18.665, 3]) cube([0.4, 37.33, 23.71]);
  }
  hull() {
    translate([177, -18.665, 3]) cube([0.4, 37.33, 23.71]);
    translate([205, -16.6, 3]) cube([0.4, 33.2, 20.6]);
  }
}
