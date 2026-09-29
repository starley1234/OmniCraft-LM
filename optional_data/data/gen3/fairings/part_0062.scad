$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 140 x 58 x 36 mm, 4 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 140;             // channel length
width = 58;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 4;                 // side wall thickness
floor_t = 3;              // floor thickness
end_w = 34.8;             // faired end width
end_h = 21.6;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -17.4, 0]) cube([0.4, 34.8, 21.6]);
      translate([12.6, -21.46, 0]) cube([0.4, 42.92, 26.64]);
    }
    hull() {
      translate([12.6, -21.46, 0]) cube([0.4, 42.92, 26.64]);
      translate([70, -29, 0]) cube([0.4, 58, 36]);
    }
    hull() {
      translate([70, -29, 0]) cube([0.4, 58, 36]);
      translate([127.4, -21.46, 0]) cube([0.4, 42.92, 26.64]);
    }
    hull() {
      translate([127.4, -21.46, 0]) cube([0.4, 42.92, 26.64]);
      translate([140, -17.4, 0]) cube([0.4, 34.8, 21.6]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -15.8, 3]) cube([0.4, 31.6, 17]);
    translate([7.6, -19.02, 3]) cube([0.4, 38.04, 21.2]);
  }
  hull() {
    translate([7.6, -19.02, 3]) cube([0.4, 38.04, 21.2]);
    translate([65, -25, 3]) cube([0.4, 50, 29]);
  }
  hull() {
    translate([65, -25, 3]) cube([0.4, 50, 29]);
    translate([122.4, -19.02, 3]) cube([0.4, 38.04, 21.2]);
  }
  hull() {
    translate([122.4, -19.02, 3]) cube([0.4, 38.04, 21.2]);
    translate([145, -15.8, 3]) cube([0.4, 31.6, 17]);
  }
}
