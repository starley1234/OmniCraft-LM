$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 160 x 52 x 42 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 160;             // channel length
width = 52;               // channel width at mid length
height = 42;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 36.4;             // faired end width
end_h = 29.4;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -18.2, 0]) cube([0.4, 36.4, 29.4]);
      translate([14.4, -20.93, 0]) cube([0.4, 41.86, 33.81]);
    }
    hull() {
      translate([14.4, -20.93, 0]) cube([0.4, 41.86, 33.81]);
      translate([80, -26, 0]) cube([0.4, 52, 42]);
    }
    hull() {
      translate([80, -26, 0]) cube([0.4, 52, 42]);
      translate([145.6, -20.93, 0]) cube([0.4, 41.86, 33.81]);
    }
    hull() {
      translate([145.6, -20.93, 0]) cube([0.4, 41.86, 33.81]);
      translate([160, -18.2, 0]) cube([0.4, 36.4, 29.4]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -16.6, 4]) cube([0.4, 33.2, 23.8]);
    translate([9.4, -18.84, 4]) cube([0.4, 37.68, 27.72]);
  }
  hull() {
    translate([9.4, -18.84, 4]) cube([0.4, 37.68, 27.72]);
    translate([75, -23, 4]) cube([0.4, 46, 35]);
  }
  hull() {
    translate([75, -23, 4]) cube([0.4, 46, 35]);
    translate([140.6, -18.84, 4]) cube([0.4, 37.68, 27.72]);
  }
  hull() {
    translate([140.6, -18.84, 4]) cube([0.4, 37.68, 27.72]);
    translate([165, -16.6, 4]) cube([0.4, 33.2, 23.8]);
  }
}
