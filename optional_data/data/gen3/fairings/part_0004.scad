$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 140 x 58 x 42 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 140;             // channel length
width = 58;               // channel width at mid length
height = 42;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 4;              // floor thickness
end_w = 37.7;             // faired end width
end_h = 27.3;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -18.85, 0]) cube([0.4, 37.7, 27.3]);
      translate([12.6, -22.4, 0]) cube([0.4, 44.8, 32.45]);
    }
    hull() {
      translate([12.6, -22.4, 0]) cube([0.4, 44.8, 32.45]);
      translate([70, -29, 0]) cube([0.4, 58, 42]);
    }
    hull() {
      translate([70, -29, 0]) cube([0.4, 58, 42]);
      translate([127.4, -22.4, 0]) cube([0.4, 44.8, 32.45]);
    }
    hull() {
      translate([127.4, -22.4, 0]) cube([0.4, 44.8, 32.45]);
      translate([140, -18.85, 0]) cube([0.4, 37.7, 27.3]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -17.25, 4]) cube([0.4, 34.5, 21.7]);
    translate([7.6, -20.135, 4]) cube([0.4, 40.27, 26.18]);
  }
  hull() {
    translate([7.6, -20.135, 4]) cube([0.4, 40.27, 26.18]);
    translate([65, -25.5, 4]) cube([0.4, 51, 34.5]);
  }
  hull() {
    translate([65, -25.5, 4]) cube([0.4, 51, 34.5]);
    translate([122.4, -20.135, 4]) cube([0.4, 40.27, 26.18]);
  }
  hull() {
    translate([122.4, -20.135, 4]) cube([0.4, 40.27, 26.18]);
    translate([145, -17.25, 4]) cube([0.4, 34.5, 21.7]);
  }
}
