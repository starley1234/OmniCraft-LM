$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 58 x 26 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 58;               // channel width at mid length
height = 26;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 3;              // floor thickness
end_w = 40.6;             // faired end width
end_h = 18.2;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -20.3, 0]) cube([0.4, 40.6, 18.2]);
      translate([18, -23.345, 0]) cube([0.4, 46.69, 20.93]);
    }
    hull() {
      translate([18, -23.345, 0]) cube([0.4, 46.69, 20.93]);
      translate([100, -29, 0]) cube([0.4, 58, 26]);
    }
    hull() {
      translate([100, -29, 0]) cube([0.4, 58, 26]);
      translate([182, -23.345, 0]) cube([0.4, 46.69, 20.93]);
    }
    hull() {
      translate([182, -23.345, 0]) cube([0.4, 46.69, 20.93]);
      translate([200, -20.3, 0]) cube([0.4, 40.6, 18.2]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -18.7, 3]) cube([0.4, 37.4, 13.6]);
    translate([13, -21.255, 3]) cube([0.4, 42.51, 15.84]);
  }
  hull() {
    translate([13, -21.255, 3]) cube([0.4, 42.51, 15.84]);
    translate([95, -26, 3]) cube([0.4, 52, 20]);
  }
  hull() {
    translate([95, -26, 3]) cube([0.4, 52, 20]);
    translate([177, -21.255, 3]) cube([0.4, 42.51, 15.84]);
  }
  hull() {
    translate([177, -21.255, 3]) cube([0.4, 42.51, 15.84]);
    translate([205, -18.7, 3]) cube([0.4, 37.4, 13.6]);
  }
}
