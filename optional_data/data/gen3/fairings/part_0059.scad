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
end_w = 34.8;             // faired end width
end_h = 25.2;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -17.4, 0]) cube([0.4, 34.8, 25.2]);
      translate([18, -21.46, 0]) cube([0.4, 42.92, 31.08]);
    }
    hull() {
      translate([18, -21.46, 0]) cube([0.4, 42.92, 31.08]);
      translate([100, -29, 0]) cube([0.4, 58, 42]);
    }
    hull() {
      translate([100, -29, 0]) cube([0.4, 58, 42]);
      translate([182, -21.46, 0]) cube([0.4, 42.92, 31.08]);
    }
    hull() {
      translate([182, -21.46, 0]) cube([0.4, 42.92, 31.08]);
      translate([200, -17.4, 0]) cube([0.4, 34.8, 25.2]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -15.8, 4]) cube([0.4, 31.6, 19.6]);
    translate([13, -19.37, 4]) cube([0.4, 38.74, 24.99]);
  }
  hull() {
    translate([13, -19.37, 4]) cube([0.4, 38.74, 24.99]);
    translate([95, -26, 4]) cube([0.4, 52, 35]);
  }
  hull() {
    translate([95, -26, 4]) cube([0.4, 52, 35]);
    translate([177, -19.37, 4]) cube([0.4, 38.74, 24.99]);
  }
  hull() {
    translate([177, -19.37, 4]) cube([0.4, 38.74, 24.99]);
    translate([205, -15.8, 4]) cube([0.4, 31.6, 19.6]);
  }
}
