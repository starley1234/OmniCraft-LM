$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 160 x 52 x 30 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 160;             // channel length
width = 52;               // channel width at mid length
height = 30;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 4;              // floor thickness
end_w = 36.4;             // faired end width
end_h = 21;               // faired end height

difference() {
  union() {
    hull() {
      translate([0, -18.2, 0]) cube([0.4, 36.4, 21]);
      translate([14.4, -20.93, 0]) cube([0.4, 41.86, 24.15]);
    }
    hull() {
      translate([14.4, -20.93, 0]) cube([0.4, 41.86, 24.15]);
      translate([80, -26, 0]) cube([0.4, 52, 30]);
    }
    hull() {
      translate([80, -26, 0]) cube([0.4, 52, 30]);
      translate([145.6, -20.93, 0]) cube([0.4, 41.86, 24.15]);
    }
    hull() {
      translate([145.6, -20.93, 0]) cube([0.4, 41.86, 24.15]);
      translate([160, -18.2, 0]) cube([0.4, 36.4, 21]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -16.6, 4]) cube([0.4, 33.2, 15.4]);
    translate([9.4, -18.665, 4]) cube([0.4, 37.33, 17.89]);
  }
  hull() {
    translate([9.4, -18.665, 4]) cube([0.4, 37.33, 17.89]);
    translate([75, -22.5, 4]) cube([0.4, 45, 22.5]);
  }
  hull() {
    translate([75, -22.5, 4]) cube([0.4, 45, 22.5]);
    translate([140.6, -18.665, 4]) cube([0.4, 37.33, 17.89]);
  }
  hull() {
    translate([140.6, -18.665, 4]) cube([0.4, 37.33, 17.89]);
    translate([165, -16.6, 4]) cube([0.4, 33.2, 15.4]);
  }
}
