$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 46 x 26 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 46;               // channel width at mid length
height = 26;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 32.2;             // faired end width
end_h = 18.2;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -16.1, 0]) cube([0.4, 32.2, 18.2]);
      translate([18, -18.515, 0]) cube([0.4, 37.03, 20.93]);
    }
    hull() {
      translate([18, -18.515, 0]) cube([0.4, 37.03, 20.93]);
      translate([100, -23, 0]) cube([0.4, 46, 26]);
    }
    hull() {
      translate([100, -23, 0]) cube([0.4, 46, 26]);
      translate([182, -18.515, 0]) cube([0.4, 37.03, 20.93]);
    }
    hull() {
      translate([182, -18.515, 0]) cube([0.4, 37.03, 20.93]);
      translate([200, -16.1, 0]) cube([0.4, 32.2, 18.2]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -14.5, 4]) cube([0.4, 29, 12.6]);
    translate([13, -16.425, 4]) cube([0.4, 32.85, 14.84]);
  }
  hull() {
    translate([13, -16.425, 4]) cube([0.4, 32.85, 14.84]);
    translate([95, -20, 4]) cube([0.4, 40, 19]);
  }
  hull() {
    translate([95, -20, 4]) cube([0.4, 40, 19]);
    translate([177, -16.425, 4]) cube([0.4, 32.85, 14.84]);
  }
  hull() {
    translate([177, -16.425, 4]) cube([0.4, 32.85, 14.84]);
    translate([205, -14.5, 4]) cube([0.4, 29, 12.6]);
  }
}
