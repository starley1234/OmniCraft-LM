$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 140 x 52 x 30 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 140;             // channel length
width = 52;               // channel width at mid length
height = 30;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 3;              // floor thickness
end_w = 33.8;             // faired end width
end_h = 19.5;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -16.9, 0]) cube([0.4, 33.8, 19.5]);
      translate([12.6, -20.085, 0]) cube([0.4, 40.17, 23.18]);
    }
    hull() {
      translate([12.6, -20.085, 0]) cube([0.4, 40.17, 23.18]);
      translate([70, -26, 0]) cube([0.4, 52, 30]);
    }
    hull() {
      translate([70, -26, 0]) cube([0.4, 52, 30]);
      translate([127.4, -20.085, 0]) cube([0.4, 40.17, 23.18]);
    }
    hull() {
      translate([127.4, -20.085, 0]) cube([0.4, 40.17, 23.18]);
      translate([140, -16.9, 0]) cube([0.4, 33.8, 19.5]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -15.3, 3]) cube([0.4, 30.6, 14.9]);
    translate([7.6, -17.82, 3]) cube([0.4, 35.64, 17.91]);
  }
  hull() {
    translate([7.6, -17.82, 3]) cube([0.4, 35.64, 17.91]);
    translate([65, -22.5, 3]) cube([0.4, 45, 23.5]);
  }
  hull() {
    translate([65, -22.5, 3]) cube([0.4, 45, 23.5]);
    translate([122.4, -17.82, 3]) cube([0.4, 35.64, 17.91]);
  }
  hull() {
    translate([122.4, -17.82, 3]) cube([0.4, 35.64, 17.91]);
    translate([145, -15.3, 3]) cube([0.4, 30.6, 14.9]);
  }
}
