$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 160 x 46 x 36 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 160;             // channel length
width = 46;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 29.9;             // faired end width
end_h = 23.4;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -14.95, 0]) cube([0.4, 29.9, 23.4]);
      translate([14.4, -17.765, 0]) cube([0.4, 35.53, 27.81]);
    }
    hull() {
      translate([14.4, -17.765, 0]) cube([0.4, 35.53, 27.81]);
      translate([80, -23, 0]) cube([0.4, 46, 36]);
    }
    hull() {
      translate([80, -23, 0]) cube([0.4, 46, 36]);
      translate([145.6, -17.765, 0]) cube([0.4, 35.53, 27.81]);
    }
    hull() {
      translate([145.6, -17.765, 0]) cube([0.4, 35.53, 27.81]);
      translate([160, -14.95, 0]) cube([0.4, 29.9, 23.4]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -13.35, 4]) cube([0.4, 26.7, 17.8]);
    translate([9.4, -15.68, 4]) cube([0.4, 31.36, 21.72]);
  }
  hull() {
    translate([9.4, -15.68, 4]) cube([0.4, 31.36, 21.72]);
    translate([75, -20, 4]) cube([0.4, 40, 29]);
  }
  hull() {
    translate([75, -20, 4]) cube([0.4, 40, 29]);
    translate([140.6, -15.68, 4]) cube([0.4, 31.36, 21.72]);
  }
  hull() {
    translate([140.6, -15.68, 4]) cube([0.4, 31.36, 21.72]);
    translate([165, -13.35, 4]) cube([0.4, 26.7, 17.8]);
  }
}
