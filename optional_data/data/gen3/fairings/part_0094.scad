$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 46 x 26 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 46;               // channel width at mid length
height = 26;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 4;              // floor thickness
end_w = 29.9;             // faired end width
end_h = 16.9;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -14.95, 0]) cube([0.4, 29.9, 16.9]);
      translate([18, -17.765, 0]) cube([0.4, 35.53, 20.09]);
    }
    hull() {
      translate([18, -17.765, 0]) cube([0.4, 35.53, 20.09]);
      translate([100, -23, 0]) cube([0.4, 46, 26]);
    }
    hull() {
      translate([100, -23, 0]) cube([0.4, 46, 26]);
      translate([182, -17.765, 0]) cube([0.4, 35.53, 20.09]);
    }
    hull() {
      translate([182, -17.765, 0]) cube([0.4, 35.53, 20.09]);
      translate([200, -14.95, 0]) cube([0.4, 29.9, 16.9]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -13.35, 4]) cube([0.4, 26.7, 11.3]);
    translate([13, -15.5, 4]) cube([0.4, 31, 13.82]);
  }
  hull() {
    translate([13, -15.5, 4]) cube([0.4, 31, 13.82]);
    translate([95, -19.5, 4]) cube([0.4, 39, 18.5]);
  }
  hull() {
    translate([95, -19.5, 4]) cube([0.4, 39, 18.5]);
    translate([177, -15.5, 4]) cube([0.4, 31, 13.82]);
  }
  hull() {
    translate([177, -15.5, 4]) cube([0.4, 31, 13.82]);
    translate([205, -13.35, 4]) cube([0.4, 26.7, 11.3]);
  }
}
