$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 140 x 46 x 42 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 140;             // channel length
width = 46;               // channel width at mid length
height = 42;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 29.9;             // faired end width
end_h = 27.3;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -14.95, 0]) cube([0.4, 29.9, 27.3]);
      translate([12.6, -17.765, 0]) cube([0.4, 35.53, 32.45]);
    }
    hull() {
      translate([12.6, -17.765, 0]) cube([0.4, 35.53, 32.45]);
      translate([70, -23, 0]) cube([0.4, 46, 42]);
    }
    hull() {
      translate([70, -23, 0]) cube([0.4, 46, 42]);
      translate([127.4, -17.765, 0]) cube([0.4, 35.53, 32.45]);
    }
    hull() {
      translate([127.4, -17.765, 0]) cube([0.4, 35.53, 32.45]);
      translate([140, -14.95, 0]) cube([0.4, 29.9, 27.3]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -13.35, 4]) cube([0.4, 26.7, 21.7]);
    translate([7.6, -15.68, 4]) cube([0.4, 31.36, 26.36]);
  }
  hull() {
    translate([7.6, -15.68, 4]) cube([0.4, 31.36, 26.36]);
    translate([65, -20, 4]) cube([0.4, 40, 35]);
  }
  hull() {
    translate([65, -20, 4]) cube([0.4, 40, 35]);
    translate([122.4, -15.68, 4]) cube([0.4, 31.36, 26.36]);
  }
  hull() {
    translate([122.4, -15.68, 4]) cube([0.4, 31.36, 26.36]);
    translate([145, -13.35, 4]) cube([0.4, 26.7, 21.7]);
  }
}
