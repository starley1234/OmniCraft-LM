$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 140 x 40 x 36 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 140;             // channel length
width = 40;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 4;              // floor thickness
end_w = 26;               // faired end width
end_h = 23.4;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -13, 0]) cube([0.4, 26, 23.4]);
      translate([12.6, -15.45, 0]) cube([0.4, 30.9, 27.81]);
    }
    hull() {
      translate([12.6, -15.45, 0]) cube([0.4, 30.9, 27.81]);
      translate([70, -20, 0]) cube([0.4, 40, 36]);
    }
    hull() {
      translate([70, -20, 0]) cube([0.4, 40, 36]);
      translate([127.4, -15.45, 0]) cube([0.4, 30.9, 27.81]);
    }
    hull() {
      translate([127.4, -15.45, 0]) cube([0.4, 30.9, 27.81]);
      translate([140, -13, 0]) cube([0.4, 26, 23.4]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -11.4, 4]) cube([0.4, 22.8, 17.8]);
    translate([7.6, -13.185, 4]) cube([0.4, 26.37, 21.55]);
  }
  hull() {
    translate([7.6, -13.185, 4]) cube([0.4, 26.37, 21.55]);
    translate([65, -16.5, 4]) cube([0.4, 33, 28.5]);
  }
  hull() {
    translate([65, -16.5, 4]) cube([0.4, 33, 28.5]);
    translate([122.4, -13.185, 4]) cube([0.4, 26.37, 21.55]);
  }
  hull() {
    translate([122.4, -13.185, 4]) cube([0.4, 26.37, 21.55]);
    translate([145, -11.4, 4]) cube([0.4, 22.8, 17.8]);
  }
}
