$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 140 x 58 x 36 mm, 4 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 140;             // channel length
width = 58;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 4;                 // side wall thickness
floor_t = 3;              // floor thickness
end_w = 40.6;             // faired end width
end_h = 25.2;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -20.3, 0]) cube([0.4, 40.6, 25.2]);
      translate([12.6, -23.345, 0]) cube([0.4, 46.69, 28.98]);
    }
    hull() {
      translate([12.6, -23.345, 0]) cube([0.4, 46.69, 28.98]);
      translate([70, -29, 0]) cube([0.4, 58, 36]);
    }
    hull() {
      translate([70, -29, 0]) cube([0.4, 58, 36]);
      translate([127.4, -23.345, 0]) cube([0.4, 46.69, 28.98]);
    }
    hull() {
      translate([127.4, -23.345, 0]) cube([0.4, 46.69, 28.98]);
      translate([140, -20.3, 0]) cube([0.4, 40.6, 25.2]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -18.7, 3]) cube([0.4, 37.4, 20.6]);
    translate([7.6, -20.905, 3]) cube([0.4, 41.81, 23.54]);
  }
  hull() {
    translate([7.6, -20.905, 3]) cube([0.4, 41.81, 23.54]);
    translate([65, -25, 3]) cube([0.4, 50, 29]);
  }
  hull() {
    translate([65, -25, 3]) cube([0.4, 50, 29]);
    translate([122.4, -20.905, 3]) cube([0.4, 41.81, 23.54]);
  }
  hull() {
    translate([122.4, -20.905, 3]) cube([0.4, 41.81, 23.54]);
    translate([145, -18.7, 3]) cube([0.4, 37.4, 20.6]);
  }
}
