$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 140 x 46 x 26 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 140;             // channel length
width = 46;               // channel width at mid length
height = 26;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 29.9;             // faired end width
end_h = 16.9;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -14.95, 0]) cube([0.4, 29.9, 16.9]);
      translate([12.6, -17.765, 0]) cube([0.4, 35.53, 20.09]);
    }
    hull() {
      translate([12.6, -17.765, 0]) cube([0.4, 35.53, 20.09]);
      translate([70, -23, 0]) cube([0.4, 46, 26]);
    }
    hull() {
      translate([70, -23, 0]) cube([0.4, 46, 26]);
      translate([127.4, -17.765, 0]) cube([0.4, 35.53, 20.09]);
    }
    hull() {
      translate([127.4, -17.765, 0]) cube([0.4, 35.53, 20.09]);
      translate([140, -14.95, 0]) cube([0.4, 29.9, 16.9]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -13.35, 4]) cube([0.4, 26.7, 11.3]);
    translate([7.6, -15.68, 4]) cube([0.4, 31.36, 14]);
  }
  hull() {
    translate([7.6, -15.68, 4]) cube([0.4, 31.36, 14]);
    translate([65, -20, 4]) cube([0.4, 40, 19]);
  }
  hull() {
    translate([65, -20, 4]) cube([0.4, 40, 19]);
    translate([122.4, -15.68, 4]) cube([0.4, 31.36, 14]);
  }
  hull() {
    translate([122.4, -15.68, 4]) cube([0.4, 31.36, 14]);
    translate([145, -13.35, 4]) cube([0.4, 26.7, 11.3]);
  }
}
