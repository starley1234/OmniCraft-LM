$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 160 x 52 x 42 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 160;             // channel length
width = 52;               // channel width at mid length
height = 42;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 3;              // floor thickness
end_w = 31.2;             // faired end width
end_h = 25.2;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -15.6, 0]) cube([0.4, 31.2, 25.2]);
      translate([14.4, -19.24, 0]) cube([0.4, 38.48, 31.08]);
    }
    hull() {
      translate([14.4, -19.24, 0]) cube([0.4, 38.48, 31.08]);
      translate([80, -26, 0]) cube([0.4, 52, 42]);
    }
    hull() {
      translate([80, -26, 0]) cube([0.4, 52, 42]);
      translate([145.6, -19.24, 0]) cube([0.4, 38.48, 31.08]);
    }
    hull() {
      translate([145.6, -19.24, 0]) cube([0.4, 38.48, 31.08]);
      translate([160, -15.6, 0]) cube([0.4, 31.2, 25.2]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -14, 3]) cube([0.4, 28, 20.6]);
    translate([9.4, -16.975, 3]) cube([0.4, 33.95, 25.82]);
  }
  hull() {
    translate([9.4, -16.975, 3]) cube([0.4, 33.95, 25.82]);
    translate([75, -22.5, 3]) cube([0.4, 45, 35.5]);
  }
  hull() {
    translate([75, -22.5, 3]) cube([0.4, 45, 35.5]);
    translate([140.6, -16.975, 3]) cube([0.4, 33.95, 25.82]);
  }
  hull() {
    translate([140.6, -16.975, 3]) cube([0.4, 33.95, 25.82]);
    translate([165, -14, 3]) cube([0.4, 28, 20.6]);
  }
}
