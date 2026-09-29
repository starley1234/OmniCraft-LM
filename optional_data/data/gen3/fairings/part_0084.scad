$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 160 x 46 x 42 mm, 4 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 160;             // channel length
width = 46;               // channel width at mid length
height = 42;              // channel height at mid length
wall = 4;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 29.9;             // faired end width
end_h = 27.3;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -14.95, 0]) cube([0.4, 29.9, 27.3]);
      translate([14.4, -17.765, 0]) cube([0.4, 35.53, 32.45]);
    }
    hull() {
      translate([14.4, -17.765, 0]) cube([0.4, 35.53, 32.45]);
      translate([80, -23, 0]) cube([0.4, 46, 42]);
    }
    hull() {
      translate([80, -23, 0]) cube([0.4, 46, 42]);
      translate([145.6, -17.765, 0]) cube([0.4, 35.53, 32.45]);
    }
    hull() {
      translate([145.6, -17.765, 0]) cube([0.4, 35.53, 32.45]);
      translate([160, -14.95, 0]) cube([0.4, 29.9, 27.3]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -13.35, 4]) cube([0.4, 26.7, 21.7]);
    translate([9.4, -15.33, 4]) cube([0.4, 30.66, 26]);
  }
  hull() {
    translate([9.4, -15.33, 4]) cube([0.4, 30.66, 26]);
    translate([75, -19, 4]) cube([0.4, 38, 34]);
  }
  hull() {
    translate([75, -19, 4]) cube([0.4, 38, 34]);
    translate([140.6, -15.33, 4]) cube([0.4, 30.66, 26]);
  }
  hull() {
    translate([140.6, -15.33, 4]) cube([0.4, 30.66, 26]);
    translate([165, -13.35, 4]) cube([0.4, 26.7, 21.7]);
  }
}
