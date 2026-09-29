$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 160 x 40 x 42 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 160;             // channel length
width = 40;               // channel width at mid length
height = 42;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 3;              // floor thickness
end_w = 24;               // faired end width
end_h = 25.2;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -12, 0]) cube([0.4, 24, 25.2]);
      translate([14.4, -14.8, 0]) cube([0.4, 29.6, 31.08]);
    }
    hull() {
      translate([14.4, -14.8, 0]) cube([0.4, 29.6, 31.08]);
      translate([80, -20, 0]) cube([0.4, 40, 42]);
    }
    hull() {
      translate([80, -20, 0]) cube([0.4, 40, 42]);
      translate([145.6, -14.8, 0]) cube([0.4, 29.6, 31.08]);
    }
    hull() {
      translate([145.6, -14.8, 0]) cube([0.4, 29.6, 31.08]);
      translate([160, -12, 0]) cube([0.4, 24, 25.2]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -10.4, 3]) cube([0.4, 20.8, 20.6]);
    translate([9.4, -12.71, 3]) cube([0.4, 25.42, 25.99]);
  }
  hull() {
    translate([9.4, -12.71, 3]) cube([0.4, 25.42, 25.99]);
    translate([75, -17, 3]) cube([0.4, 34, 36]);
  }
  hull() {
    translate([75, -17, 3]) cube([0.4, 34, 36]);
    translate([140.6, -12.71, 3]) cube([0.4, 25.42, 25.99]);
  }
  hull() {
    translate([140.6, -12.71, 3]) cube([0.4, 25.42, 25.99]);
    translate([165, -10.4, 3]) cube([0.4, 20.8, 20.6]);
  }
}
