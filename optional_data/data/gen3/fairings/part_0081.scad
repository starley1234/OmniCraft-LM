$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 46 x 30 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 46;               // channel width at mid length
height = 30;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 4;              // floor thickness
end_w = 32.2;             // faired end width
end_h = 21;               // faired end height

difference() {
  union() {
    hull() {
      translate([0, -16.1, 0]) cube([0.4, 32.2, 21]);
      translate([18, -18.515, 0]) cube([0.4, 37.03, 24.15]);
    }
    hull() {
      translate([18, -18.515, 0]) cube([0.4, 37.03, 24.15]);
      translate([100, -23, 0]) cube([0.4, 46, 30]);
    }
    hull() {
      translate([100, -23, 0]) cube([0.4, 46, 30]);
      translate([182, -18.515, 0]) cube([0.4, 37.03, 24.15]);
    }
    hull() {
      translate([182, -18.515, 0]) cube([0.4, 37.03, 24.15]);
      translate([200, -16.1, 0]) cube([0.4, 32.2, 21]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -14.5, 4]) cube([0.4, 29, 15.4]);
    translate([13, -16.25, 4]) cube([0.4, 32.5, 17.89]);
  }
  hull() {
    translate([13, -16.25, 4]) cube([0.4, 32.5, 17.89]);
    translate([95, -19.5, 4]) cube([0.4, 39, 22.5]);
  }
  hull() {
    translate([95, -19.5, 4]) cube([0.4, 39, 22.5]);
    translate([177, -16.25, 4]) cube([0.4, 32.5, 17.89]);
  }
  hull() {
    translate([177, -16.25, 4]) cube([0.4, 32.5, 17.89]);
    translate([205, -14.5, 4]) cube([0.4, 29, 15.4]);
  }
}
