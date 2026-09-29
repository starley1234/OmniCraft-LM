$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 58 x 30 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 58;               // channel width at mid length
height = 30;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 40.6;             // faired end width
end_h = 21;               // faired end height

difference() {
  union() {
    hull() {
      translate([0, -20.3, 0]) cube([0.4, 40.6, 21]);
      translate([18, -23.345, 0]) cube([0.4, 46.69, 24.15]);
    }
    hull() {
      translate([18, -23.345, 0]) cube([0.4, 46.69, 24.15]);
      translate([100, -29, 0]) cube([0.4, 58, 30]);
    }
    hull() {
      translate([100, -29, 0]) cube([0.4, 58, 30]);
      translate([182, -23.345, 0]) cube([0.4, 46.69, 24.15]);
    }
    hull() {
      translate([182, -23.345, 0]) cube([0.4, 46.69, 24.15]);
      translate([200, -20.3, 0]) cube([0.4, 40.6, 21]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -18.7, 4]) cube([0.4, 37.4, 15.4]);
    translate([13, -21.255, 4]) cube([0.4, 42.51, 18.06]);
  }
  hull() {
    translate([13, -21.255, 4]) cube([0.4, 42.51, 18.06]);
    translate([95, -26, 4]) cube([0.4, 52, 23]);
  }
  hull() {
    translate([95, -26, 4]) cube([0.4, 52, 23]);
    translate([177, -21.255, 4]) cube([0.4, 42.51, 18.06]);
  }
  hull() {
    translate([177, -21.255, 4]) cube([0.4, 42.51, 18.06]);
    translate([205, -18.7, 4]) cube([0.4, 37.4, 15.4]);
  }
}
