$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 160 x 46 x 26 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 160;             // channel length
width = 46;               // channel width at mid length
height = 26;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 3;              // floor thickness
end_w = 32.2;             // faired end width
end_h = 18.2;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -16.1, 0]) cube([0.4, 32.2, 18.2]);
      translate([14.4, -18.515, 0]) cube([0.4, 37.03, 20.93]);
    }
    hull() {
      translate([14.4, -18.515, 0]) cube([0.4, 37.03, 20.93]);
      translate([80, -23, 0]) cube([0.4, 46, 26]);
    }
    hull() {
      translate([80, -23, 0]) cube([0.4, 46, 26]);
      translate([145.6, -18.515, 0]) cube([0.4, 37.03, 20.93]);
    }
    hull() {
      translate([145.6, -18.515, 0]) cube([0.4, 37.03, 20.93]);
      translate([160, -16.1, 0]) cube([0.4, 32.2, 18.2]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -14.5, 3]) cube([0.4, 29, 13.6]);
    translate([9.4, -16.25, 3]) cube([0.4, 32.5, 15.66]);
  }
  hull() {
    translate([9.4, -16.25, 3]) cube([0.4, 32.5, 15.66]);
    translate([75, -19.5, 3]) cube([0.4, 39, 19.5]);
  }
  hull() {
    translate([75, -19.5, 3]) cube([0.4, 39, 19.5]);
    translate([140.6, -16.25, 3]) cube([0.4, 32.5, 15.66]);
  }
  hull() {
    translate([140.6, -16.25, 3]) cube([0.4, 32.5, 15.66]);
    translate([165, -14.5, 3]) cube([0.4, 29, 13.6]);
  }
}
