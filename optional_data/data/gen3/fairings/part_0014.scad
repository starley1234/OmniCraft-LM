$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 52 x 26 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 52;               // channel width at mid length
height = 26;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 3;              // floor thickness
end_w = 36.4;             // faired end width
end_h = 18.2;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -18.2, 0]) cube([0.4, 36.4, 18.2]);
      translate([18, -20.93, 0]) cube([0.4, 41.86, 20.93]);
    }
    hull() {
      translate([18, -20.93, 0]) cube([0.4, 41.86, 20.93]);
      translate([100, -26, 0]) cube([0.4, 52, 26]);
    }
    hull() {
      translate([100, -26, 0]) cube([0.4, 52, 26]);
      translate([182, -20.93, 0]) cube([0.4, 41.86, 20.93]);
    }
    hull() {
      translate([182, -20.93, 0]) cube([0.4, 41.86, 20.93]);
      translate([200, -18.2, 0]) cube([0.4, 36.4, 18.2]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -16.6, 3]) cube([0.4, 33.2, 13.6]);
    translate([13, -18.84, 3]) cube([0.4, 37.68, 15.84]);
  }
  hull() {
    translate([13, -18.84, 3]) cube([0.4, 37.68, 15.84]);
    translate([95, -23, 3]) cube([0.4, 46, 20]);
  }
  hull() {
    translate([95, -23, 3]) cube([0.4, 46, 20]);
    translate([177, -18.84, 3]) cube([0.4, 37.68, 15.84]);
  }
  hull() {
    translate([177, -18.84, 3]) cube([0.4, 37.68, 15.84]);
    translate([205, -16.6, 3]) cube([0.4, 33.2, 13.6]);
  }
}
