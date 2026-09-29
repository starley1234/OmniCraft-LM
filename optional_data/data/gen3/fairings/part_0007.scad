$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 140 x 40 x 26 mm, 4 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 140;             // channel length
width = 40;               // channel width at mid length
height = 26;              // channel height at mid length
wall = 4;                 // side wall thickness
floor_t = 3;              // floor thickness
end_w = 28;               // faired end width
end_h = 18.2;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -14, 0]) cube([0.4, 28, 18.2]);
      translate([12.6, -16.1, 0]) cube([0.4, 32.2, 20.93]);
    }
    hull() {
      translate([12.6, -16.1, 0]) cube([0.4, 32.2, 20.93]);
      translate([70, -20, 0]) cube([0.4, 40, 26]);
    }
    hull() {
      translate([70, -20, 0]) cube([0.4, 40, 26]);
      translate([127.4, -16.1, 0]) cube([0.4, 32.2, 20.93]);
    }
    hull() {
      translate([127.4, -16.1, 0]) cube([0.4, 32.2, 20.93]);
      translate([140, -14, 0]) cube([0.4, 28, 18.2]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -12.4, 3]) cube([0.4, 24.8, 13.6]);
    translate([7.6, -13.66, 3]) cube([0.4, 27.32, 15.49]);
  }
  hull() {
    translate([7.6, -13.66, 3]) cube([0.4, 27.32, 15.49]);
    translate([65, -16, 3]) cube([0.4, 32, 19]);
  }
  hull() {
    translate([65, -16, 3]) cube([0.4, 32, 19]);
    translate([122.4, -13.66, 3]) cube([0.4, 27.32, 15.49]);
  }
  hull() {
    translate([122.4, -13.66, 3]) cube([0.4, 27.32, 15.49]);
    translate([145, -12.4, 3]) cube([0.4, 24.8, 13.6]);
  }
}
