$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 52 x 30 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 52;               // channel width at mid length
height = 30;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 4;              // floor thickness
end_w = 33.8;             // faired end width
end_h = 19.5;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -16.9, 0]) cube([0.4, 33.8, 19.5]);
      translate([18, -20.085, 0]) cube([0.4, 40.17, 23.18]);
    }
    hull() {
      translate([18, -20.085, 0]) cube([0.4, 40.17, 23.18]);
      translate([100, -26, 0]) cube([0.4, 52, 30]);
    }
    hull() {
      translate([100, -26, 0]) cube([0.4, 52, 30]);
      translate([182, -20.085, 0]) cube([0.4, 40.17, 23.18]);
    }
    hull() {
      translate([182, -20.085, 0]) cube([0.4, 40.17, 23.18]);
      translate([200, -16.9, 0]) cube([0.4, 33.8, 19.5]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -15.3, 4]) cube([0.4, 30.6, 13.9]);
    translate([13, -17.82, 4]) cube([0.4, 35.64, 16.91]);
  }
  hull() {
    translate([13, -17.82, 4]) cube([0.4, 35.64, 16.91]);
    translate([95, -22.5, 4]) cube([0.4, 45, 22.5]);
  }
  hull() {
    translate([95, -22.5, 4]) cube([0.4, 45, 22.5]);
    translate([177, -17.82, 4]) cube([0.4, 35.64, 16.91]);
  }
  hull() {
    translate([177, -17.82, 4]) cube([0.4, 35.64, 16.91]);
    translate([205, -15.3, 4]) cube([0.4, 30.6, 13.9]);
  }
}
