$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 140 x 40 x 26 mm, 4 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 140;             // channel length
width = 40;               // channel width at mid length
height = 26;              // channel height at mid length
wall = 4;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 24;               // faired end width
end_h = 15.6;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -12, 0]) cube([0.4, 24, 15.6]);
      translate([12.6, -14.8, 0]) cube([0.4, 29.6, 19.24]);
    }
    hull() {
      translate([12.6, -14.8, 0]) cube([0.4, 29.6, 19.24]);
      translate([70, -20, 0]) cube([0.4, 40, 26]);
    }
    hull() {
      translate([70, -20, 0]) cube([0.4, 40, 26]);
      translate([127.4, -14.8, 0]) cube([0.4, 29.6, 19.24]);
    }
    hull() {
      translate([127.4, -14.8, 0]) cube([0.4, 29.6, 19.24]);
      translate([140, -12, 0]) cube([0.4, 24, 15.6]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -10.4, 4]) cube([0.4, 20.8, 10]);
    translate([7.6, -12.36, 4]) cube([0.4, 24.72, 12.8]);
  }
  hull() {
    translate([7.6, -12.36, 4]) cube([0.4, 24.72, 12.8]);
    translate([65, -16, 4]) cube([0.4, 32, 18]);
  }
  hull() {
    translate([65, -16, 4]) cube([0.4, 32, 18]);
    translate([122.4, -12.36, 4]) cube([0.4, 24.72, 12.8]);
  }
  hull() {
    translate([122.4, -12.36, 4]) cube([0.4, 24.72, 12.8]);
    translate([145, -10.4, 4]) cube([0.4, 20.8, 10]);
  }
}
