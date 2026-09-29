$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 160 x 58 x 36 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 160;             // channel length
width = 58;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 3;              // floor thickness
end_w = 34.8;             // faired end width
end_h = 21.6;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -17.4, 0]) cube([0.4, 34.8, 21.6]);
      translate([14.4, -21.46, 0]) cube([0.4, 42.92, 26.64]);
    }
    hull() {
      translate([14.4, -21.46, 0]) cube([0.4, 42.92, 26.64]);
      translate([80, -29, 0]) cube([0.4, 58, 36]);
    }
    hull() {
      translate([80, -29, 0]) cube([0.4, 58, 36]);
      translate([145.6, -21.46, 0]) cube([0.4, 42.92, 26.64]);
    }
    hull() {
      translate([145.6, -21.46, 0]) cube([0.4, 42.92, 26.64]);
      translate([160, -17.4, 0]) cube([0.4, 34.8, 21.6]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -15.8, 3]) cube([0.4, 31.6, 17]);
    translate([9.4, -19.37, 3]) cube([0.4, 38.74, 21.55]);
  }
  hull() {
    translate([9.4, -19.37, 3]) cube([0.4, 38.74, 21.55]);
    translate([75, -26, 3]) cube([0.4, 52, 30]);
  }
  hull() {
    translate([75, -26, 3]) cube([0.4, 52, 30]);
    translate([140.6, -19.37, 3]) cube([0.4, 38.74, 21.55]);
  }
  hull() {
    translate([140.6, -19.37, 3]) cube([0.4, 38.74, 21.55]);
    translate([165, -15.8, 3]) cube([0.4, 31.6, 17]);
  }
}
