$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 58 x 36 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 58;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 3;              // floor thickness
end_w = 34.8;             // faired end width
end_h = 21.6;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -17.4, 0]) cube([0.4, 34.8, 21.6]);
      translate([18, -21.46, 0]) cube([0.4, 42.92, 26.64]);
    }
    hull() {
      translate([18, -21.46, 0]) cube([0.4, 42.92, 26.64]);
      translate([100, -29, 0]) cube([0.4, 58, 36]);
    }
    hull() {
      translate([100, -29, 0]) cube([0.4, 58, 36]);
      translate([182, -21.46, 0]) cube([0.4, 42.92, 26.64]);
    }
    hull() {
      translate([182, -21.46, 0]) cube([0.4, 42.92, 26.64]);
      translate([200, -17.4, 0]) cube([0.4, 34.8, 21.6]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -15.8, 3]) cube([0.4, 31.6, 17]);
    translate([13, -19.195, 3]) cube([0.4, 38.39, 21.38]);
  }
  hull() {
    translate([13, -19.195, 3]) cube([0.4, 38.39, 21.38]);
    translate([95, -25.5, 3]) cube([0.4, 51, 29.5]);
  }
  hull() {
    translate([95, -25.5, 3]) cube([0.4, 51, 29.5]);
    translate([177, -19.195, 3]) cube([0.4, 38.39, 21.38]);
  }
  hull() {
    translate([177, -19.195, 3]) cube([0.4, 38.39, 21.38]);
    translate([205, -15.8, 3]) cube([0.4, 31.6, 17]);
  }
}
