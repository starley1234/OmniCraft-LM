$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 140 x 46 x 36 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 140;             // channel length
width = 46;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 3;              // floor thickness
end_w = 27.6;             // faired end width
end_h = 21.6;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -13.8, 0]) cube([0.4, 27.6, 21.6]);
      translate([12.6, -17.02, 0]) cube([0.4, 34.04, 26.64]);
    }
    hull() {
      translate([12.6, -17.02, 0]) cube([0.4, 34.04, 26.64]);
      translate([70, -23, 0]) cube([0.4, 46, 36]);
    }
    hull() {
      translate([70, -23, 0]) cube([0.4, 46, 36]);
      translate([127.4, -17.02, 0]) cube([0.4, 34.04, 26.64]);
    }
    hull() {
      translate([127.4, -17.02, 0]) cube([0.4, 34.04, 26.64]);
      translate([140, -13.8, 0]) cube([0.4, 27.6, 21.6]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -12.2, 3]) cube([0.4, 24.4, 17]);
    translate([7.6, -14.755, 3]) cube([0.4, 29.51, 21.38]);
  }
  hull() {
    translate([7.6, -14.755, 3]) cube([0.4, 29.51, 21.38]);
    translate([65, -19.5, 3]) cube([0.4, 39, 29.5]);
  }
  hull() {
    translate([65, -19.5, 3]) cube([0.4, 39, 29.5]);
    translate([122.4, -14.755, 3]) cube([0.4, 29.51, 21.38]);
  }
  hull() {
    translate([122.4, -14.755, 3]) cube([0.4, 29.51, 21.38]);
    translate([145, -12.2, 3]) cube([0.4, 24.4, 17]);
  }
}
