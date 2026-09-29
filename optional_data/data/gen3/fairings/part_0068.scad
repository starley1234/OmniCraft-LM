$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 46 x 36 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 46;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 3;              // floor thickness
end_w = 27.6;             // faired end width
end_h = 21.6;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -13.8, 0]) cube([0.4, 27.6, 21.6]);
      translate([18, -17.02, 0]) cube([0.4, 34.04, 26.64]);
    }
    hull() {
      translate([18, -17.02, 0]) cube([0.4, 34.04, 26.64]);
      translate([100, -23, 0]) cube([0.4, 46, 36]);
    }
    hull() {
      translate([100, -23, 0]) cube([0.4, 46, 36]);
      translate([182, -17.02, 0]) cube([0.4, 34.04, 26.64]);
    }
    hull() {
      translate([182, -17.02, 0]) cube([0.4, 34.04, 26.64]);
      translate([200, -13.8, 0]) cube([0.4, 27.6, 21.6]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -12.2, 3]) cube([0.4, 24.4, 17]);
    translate([13, -14.93, 3]) cube([0.4, 29.86, 21.55]);
  }
  hull() {
    translate([13, -14.93, 3]) cube([0.4, 29.86, 21.55]);
    translate([95, -20, 3]) cube([0.4, 40, 30]);
  }
  hull() {
    translate([95, -20, 3]) cube([0.4, 40, 30]);
    translate([177, -14.93, 3]) cube([0.4, 29.86, 21.55]);
  }
  hull() {
    translate([177, -14.93, 3]) cube([0.4, 29.86, 21.55]);
    translate([205, -12.2, 3]) cube([0.4, 24.4, 17]);
  }
}
