$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 52 x 42 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 52;               // channel width at mid length
height = 42;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 3;              // floor thickness
end_w = 33.8;             // faired end width
end_h = 27.3;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -16.9, 0]) cube([0.4, 33.8, 27.3]);
      translate([18, -20.085, 0]) cube([0.4, 40.17, 32.45]);
    }
    hull() {
      translate([18, -20.085, 0]) cube([0.4, 40.17, 32.45]);
      translate([100, -26, 0]) cube([0.4, 52, 42]);
    }
    hull() {
      translate([100, -26, 0]) cube([0.4, 52, 42]);
      translate([182, -20.085, 0]) cube([0.4, 40.17, 32.45]);
    }
    hull() {
      translate([182, -20.085, 0]) cube([0.4, 40.17, 32.45]);
      translate([200, -16.9, 0]) cube([0.4, 33.8, 27.3]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -15.3, 3]) cube([0.4, 30.6, 22.7]);
    translate([13, -17.82, 3]) cube([0.4, 35.64, 27.18]);
  }
  hull() {
    translate([13, -17.82, 3]) cube([0.4, 35.64, 27.18]);
    translate([95, -22.5, 3]) cube([0.4, 45, 35.5]);
  }
  hull() {
    translate([95, -22.5, 3]) cube([0.4, 45, 35.5]);
    translate([177, -17.82, 3]) cube([0.4, 35.64, 27.18]);
  }
  hull() {
    translate([177, -17.82, 3]) cube([0.4, 35.64, 27.18]);
    translate([205, -15.3, 3]) cube([0.4, 30.6, 22.7]);
  }
}
