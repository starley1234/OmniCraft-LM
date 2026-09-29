$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 58 x 26 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 58;               // channel width at mid length
height = 26;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 3;              // floor thickness
end_w = 37.7;             // faired end width
end_h = 16.9;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -18.85, 0]) cube([0.4, 37.7, 16.9]);
      translate([18, -22.4, 0]) cube([0.4, 44.8, 20.09]);
    }
    hull() {
      translate([18, -22.4, 0]) cube([0.4, 44.8, 20.09]);
      translate([100, -29, 0]) cube([0.4, 58, 26]);
    }
    hull() {
      translate([100, -29, 0]) cube([0.4, 58, 26]);
      translate([182, -22.4, 0]) cube([0.4, 44.8, 20.09]);
    }
    hull() {
      translate([182, -22.4, 0]) cube([0.4, 44.8, 20.09]);
      translate([200, -18.85, 0]) cube([0.4, 37.7, 16.9]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -17.25, 3]) cube([0.4, 34.5, 12.3]);
    translate([13, -20.135, 3]) cube([0.4, 40.27, 14.82]);
  }
  hull() {
    translate([13, -20.135, 3]) cube([0.4, 40.27, 14.82]);
    translate([95, -25.5, 3]) cube([0.4, 51, 19.5]);
  }
  hull() {
    translate([95, -25.5, 3]) cube([0.4, 51, 19.5]);
    translate([177, -20.135, 3]) cube([0.4, 40.27, 14.82]);
  }
  hull() {
    translate([177, -20.135, 3]) cube([0.4, 40.27, 14.82]);
    translate([205, -17.25, 3]) cube([0.4, 34.5, 12.3]);
  }
}
