$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 40 x 26 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 40;               // channel width at mid length
height = 26;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 24;               // faired end width
end_h = 15.6;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -12, 0]) cube([0.4, 24, 15.6]);
      translate([18, -14.8, 0]) cube([0.4, 29.6, 19.24]);
    }
    hull() {
      translate([18, -14.8, 0]) cube([0.4, 29.6, 19.24]);
      translate([100, -20, 0]) cube([0.4, 40, 26]);
    }
    hull() {
      translate([100, -20, 0]) cube([0.4, 40, 26]);
      translate([182, -14.8, 0]) cube([0.4, 29.6, 19.24]);
    }
    hull() {
      translate([182, -14.8, 0]) cube([0.4, 29.6, 19.24]);
      translate([200, -12, 0]) cube([0.4, 24, 15.6]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -10.4, 4]) cube([0.4, 20.8, 10]);
    translate([13, -12.71, 4]) cube([0.4, 25.42, 13.15]);
  }
  hull() {
    translate([13, -12.71, 4]) cube([0.4, 25.42, 13.15]);
    translate([95, -17, 4]) cube([0.4, 34, 19]);
  }
  hull() {
    translate([95, -17, 4]) cube([0.4, 34, 19]);
    translate([177, -12.71, 4]) cube([0.4, 25.42, 13.15]);
  }
  hull() {
    translate([177, -12.71, 4]) cube([0.4, 25.42, 13.15]);
    translate([205, -10.4, 4]) cube([0.4, 20.8, 10]);
  }
}
