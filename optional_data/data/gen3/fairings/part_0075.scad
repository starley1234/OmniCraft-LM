$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 140 x 52 x 36 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 140;             // channel length
width = 52;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 3;              // floor thickness
end_w = 33.8;             // faired end width
end_h = 23.4;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -16.9, 0]) cube([0.4, 33.8, 23.4]);
      translate([12.6, -20.085, 0]) cube([0.4, 40.17, 27.81]);
    }
    hull() {
      translate([12.6, -20.085, 0]) cube([0.4, 40.17, 27.81]);
      translate([70, -26, 0]) cube([0.4, 52, 36]);
    }
    hull() {
      translate([70, -26, 0]) cube([0.4, 52, 36]);
      translate([127.4, -20.085, 0]) cube([0.4, 40.17, 27.81]);
    }
    hull() {
      translate([127.4, -20.085, 0]) cube([0.4, 40.17, 27.81]);
      translate([140, -16.9, 0]) cube([0.4, 33.8, 23.4]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -15.3, 3]) cube([0.4, 30.6, 18.8]);
    translate([7.6, -17.995, 3]) cube([0.4, 35.99, 22.72]);
  }
  hull() {
    translate([7.6, -17.995, 3]) cube([0.4, 35.99, 22.72]);
    translate([65, -23, 3]) cube([0.4, 46, 30]);
  }
  hull() {
    translate([65, -23, 3]) cube([0.4, 46, 30]);
    translate([122.4, -17.995, 3]) cube([0.4, 35.99, 22.72]);
  }
  hull() {
    translate([122.4, -17.995, 3]) cube([0.4, 35.99, 22.72]);
    translate([145, -15.3, 3]) cube([0.4, 30.6, 18.8]);
  }
}
