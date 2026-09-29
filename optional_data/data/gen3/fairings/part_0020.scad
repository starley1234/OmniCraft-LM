$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 46 x 26 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 46;               // channel width at mid length
height = 26;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 3;              // floor thickness
end_w = 27.6;             // faired end width
end_h = 15.6;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -13.8, 0]) cube([0.4, 27.6, 15.6]);
      translate([18, -17.02, 0]) cube([0.4, 34.04, 19.24]);
    }
    hull() {
      translate([18, -17.02, 0]) cube([0.4, 34.04, 19.24]);
      translate([100, -23, 0]) cube([0.4, 46, 26]);
    }
    hull() {
      translate([100, -23, 0]) cube([0.4, 46, 26]);
      translate([182, -17.02, 0]) cube([0.4, 34.04, 19.24]);
    }
    hull() {
      translate([182, -17.02, 0]) cube([0.4, 34.04, 19.24]);
      translate([200, -13.8, 0]) cube([0.4, 27.6, 15.6]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -12.2, 3]) cube([0.4, 24.4, 11]);
    translate([13, -14.93, 3]) cube([0.4, 29.86, 14.15]);
  }
  hull() {
    translate([13, -14.93, 3]) cube([0.4, 29.86, 14.15]);
    translate([95, -20, 3]) cube([0.4, 40, 20]);
  }
  hull() {
    translate([95, -20, 3]) cube([0.4, 40, 20]);
    translate([177, -14.93, 3]) cube([0.4, 29.86, 14.15]);
  }
  hull() {
    translate([177, -14.93, 3]) cube([0.4, 29.86, 14.15]);
    translate([205, -12.2, 3]) cube([0.4, 24.4, 11]);
  }
}
