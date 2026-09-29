$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 140 x 52 x 36 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 140;             // channel length
width = 52;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 3;              // floor thickness
end_w = 31.2;             // faired end width
end_h = 21.6;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -15.6, 0]) cube([0.4, 31.2, 21.6]);
      translate([12.6, -19.24, 0]) cube([0.4, 38.48, 26.64]);
    }
    hull() {
      translate([12.6, -19.24, 0]) cube([0.4, 38.48, 26.64]);
      translate([70, -26, 0]) cube([0.4, 52, 36]);
    }
    hull() {
      translate([70, -26, 0]) cube([0.4, 52, 36]);
      translate([127.4, -19.24, 0]) cube([0.4, 38.48, 26.64]);
    }
    hull() {
      translate([127.4, -19.24, 0]) cube([0.4, 38.48, 26.64]);
      translate([140, -15.6, 0]) cube([0.4, 31.2, 21.6]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -14, 3]) cube([0.4, 28, 17]);
    translate([7.6, -16.975, 3]) cube([0.4, 33.95, 21.38]);
  }
  hull() {
    translate([7.6, -16.975, 3]) cube([0.4, 33.95, 21.38]);
    translate([65, -22.5, 3]) cube([0.4, 45, 29.5]);
  }
  hull() {
    translate([65, -22.5, 3]) cube([0.4, 45, 29.5]);
    translate([122.4, -16.975, 3]) cube([0.4, 33.95, 21.38]);
  }
  hull() {
    translate([122.4, -16.975, 3]) cube([0.4, 33.95, 21.38]);
    translate([145, -14, 3]) cube([0.4, 28, 17]);
  }
}
