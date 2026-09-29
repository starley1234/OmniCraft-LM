$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 140 x 52 x 36 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 140;             // channel length
width = 52;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 36.4;             // faired end width
end_h = 25.2;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -18.2, 0]) cube([0.4, 36.4, 25.2]);
      translate([12.6, -20.93, 0]) cube([0.4, 41.86, 28.98]);
    }
    hull() {
      translate([12.6, -20.93, 0]) cube([0.4, 41.86, 28.98]);
      translate([70, -26, 0]) cube([0.4, 52, 36]);
    }
    hull() {
      translate([70, -26, 0]) cube([0.4, 52, 36]);
      translate([127.4, -20.93, 0]) cube([0.4, 41.86, 28.98]);
    }
    hull() {
      translate([127.4, -20.93, 0]) cube([0.4, 41.86, 28.98]);
      translate([140, -18.2, 0]) cube([0.4, 36.4, 25.2]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -16.6, 4]) cube([0.4, 33.2, 19.6]);
    translate([7.6, -18.84, 4]) cube([0.4, 37.68, 22.89]);
  }
  hull() {
    translate([7.6, -18.84, 4]) cube([0.4, 37.68, 22.89]);
    translate([65, -23, 4]) cube([0.4, 46, 29]);
  }
  hull() {
    translate([65, -23, 4]) cube([0.4, 46, 29]);
    translate([122.4, -18.84, 4]) cube([0.4, 37.68, 22.89]);
  }
  hull() {
    translate([122.4, -18.84, 4]) cube([0.4, 37.68, 22.89]);
    translate([145, -16.6, 4]) cube([0.4, 33.2, 19.6]);
  }
}
