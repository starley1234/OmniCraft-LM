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
end_w = 31.2;             // faired end width
end_h = 18;               // faired end height

difference() {
  union() {
    hull() {
      translate([0, -15.6, 0]) cube([0.4, 31.2, 18]);
      translate([18, -19.24, 0]) cube([0.4, 38.48, 22.2]);
    }
    hull() {
      translate([18, -19.24, 0]) cube([0.4, 38.48, 22.2]);
      translate([100, -26, 0]) cube([0.4, 52, 30]);
    }
    hull() {
      translate([100, -26, 0]) cube([0.4, 52, 30]);
      translate([182, -19.24, 0]) cube([0.4, 38.48, 22.2]);
    }
    hull() {
      translate([182, -19.24, 0]) cube([0.4, 38.48, 22.2]);
      translate([200, -15.6, 0]) cube([0.4, 31.2, 18]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -14, 4]) cube([0.4, 28, 12.4]);
    translate([13, -16.975, 4]) cube([0.4, 33.95, 15.94]);
  }
  hull() {
    translate([13, -16.975, 4]) cube([0.4, 33.95, 15.94]);
    translate([95, -22.5, 4]) cube([0.4, 45, 22.5]);
  }
  hull() {
    translate([95, -22.5, 4]) cube([0.4, 45, 22.5]);
    translate([177, -16.975, 4]) cube([0.4, 33.95, 15.94]);
  }
  hull() {
    translate([177, -16.975, 4]) cube([0.4, 33.95, 15.94]);
    translate([205, -14, 4]) cube([0.4, 28, 12.4]);
  }
}
