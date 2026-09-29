$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 52 x 26 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 52;               // channel width at mid length
height = 26;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 33.8;             // faired end width
end_h = 16.9;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -16.9, 0]) cube([0.4, 33.8, 16.9]);
      translate([18, -20.085, 0]) cube([0.4, 40.17, 20.09]);
    }
    hull() {
      translate([18, -20.085, 0]) cube([0.4, 40.17, 20.09]);
      translate([100, -26, 0]) cube([0.4, 52, 26]);
    }
    hull() {
      translate([100, -26, 0]) cube([0.4, 52, 26]);
      translate([182, -20.085, 0]) cube([0.4, 40.17, 20.09]);
    }
    hull() {
      translate([182, -20.085, 0]) cube([0.4, 40.17, 20.09]);
      translate([200, -16.9, 0]) cube([0.4, 33.8, 16.9]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -15.3, 4]) cube([0.4, 30.6, 11.3]);
    translate([13, -17.995, 4]) cube([0.4, 35.99, 14]);
  }
  hull() {
    translate([13, -17.995, 4]) cube([0.4, 35.99, 14]);
    translate([95, -23, 4]) cube([0.4, 46, 19]);
  }
  hull() {
    translate([95, -23, 4]) cube([0.4, 46, 19]);
    translate([177, -17.995, 4]) cube([0.4, 35.99, 14]);
  }
  hull() {
    translate([177, -17.995, 4]) cube([0.4, 35.99, 14]);
    translate([205, -15.3, 4]) cube([0.4, 30.6, 11.3]);
  }
}
