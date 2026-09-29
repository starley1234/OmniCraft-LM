$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 160 x 58 x 42 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 160;             // channel length
width = 58;               // channel width at mid length
height = 42;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 3;              // floor thickness
end_w = 37.7;             // faired end width
end_h = 27.3;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -18.85, 0]) cube([0.4, 37.7, 27.3]);
      translate([14.4, -22.4, 0]) cube([0.4, 44.8, 32.45]);
    }
    hull() {
      translate([14.4, -22.4, 0]) cube([0.4, 44.8, 32.45]);
      translate([80, -29, 0]) cube([0.4, 58, 42]);
    }
    hull() {
      translate([80, -29, 0]) cube([0.4, 58, 42]);
      translate([145.6, -22.4, 0]) cube([0.4, 44.8, 32.45]);
    }
    hull() {
      translate([145.6, -22.4, 0]) cube([0.4, 44.8, 32.45]);
      translate([160, -18.85, 0]) cube([0.4, 37.7, 27.3]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -17.25, 3]) cube([0.4, 34.5, 22.7]);
    translate([9.4, -20.135, 3]) cube([0.4, 40.27, 27.18]);
  }
  hull() {
    translate([9.4, -20.135, 3]) cube([0.4, 40.27, 27.18]);
    translate([75, -25.5, 3]) cube([0.4, 51, 35.5]);
  }
  hull() {
    translate([75, -25.5, 3]) cube([0.4, 51, 35.5]);
    translate([140.6, -20.135, 3]) cube([0.4, 40.27, 27.18]);
  }
  hull() {
    translate([140.6, -20.135, 3]) cube([0.4, 40.27, 27.18]);
    translate([165, -17.25, 3]) cube([0.4, 34.5, 22.7]);
  }
}
