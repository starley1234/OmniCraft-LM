$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 40 x 26 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 40;               // channel width at mid length
height = 26;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 4;              // floor thickness
end_w = 26;               // faired end width
end_h = 16.9;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -13, 0]) cube([0.4, 26, 16.9]);
      translate([18, -15.45, 0]) cube([0.4, 30.9, 20.09]);
    }
    hull() {
      translate([18, -15.45, 0]) cube([0.4, 30.9, 20.09]);
      translate([100, -20, 0]) cube([0.4, 40, 26]);
    }
    hull() {
      translate([100, -20, 0]) cube([0.4, 40, 26]);
      translate([182, -15.45, 0]) cube([0.4, 30.9, 20.09]);
    }
    hull() {
      translate([182, -15.45, 0]) cube([0.4, 30.9, 20.09]);
      translate([200, -13, 0]) cube([0.4, 26, 16.9]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -11.4, 4]) cube([0.4, 22.8, 11.3]);
    translate([13, -13.185, 4]) cube([0.4, 26.37, 13.82]);
  }
  hull() {
    translate([13, -13.185, 4]) cube([0.4, 26.37, 13.82]);
    translate([95, -16.5, 4]) cube([0.4, 33, 18.5]);
  }
  hull() {
    translate([95, -16.5, 4]) cube([0.4, 33, 18.5]);
    translate([177, -13.185, 4]) cube([0.4, 26.37, 13.82]);
  }
  hull() {
    translate([177, -13.185, 4]) cube([0.4, 26.37, 13.82]);
    translate([205, -11.4, 4]) cube([0.4, 22.8, 11.3]);
  }
}
