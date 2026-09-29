$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 160 x 40 x 36 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 160;             // channel length
width = 40;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 26;               // faired end width
end_h = 23.4;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -13, 0]) cube([0.4, 26, 23.4]);
      translate([14.4, -15.45, 0]) cube([0.4, 30.9, 27.81]);
    }
    hull() {
      translate([14.4, -15.45, 0]) cube([0.4, 30.9, 27.81]);
      translate([80, -20, 0]) cube([0.4, 40, 36]);
    }
    hull() {
      translate([80, -20, 0]) cube([0.4, 40, 36]);
      translate([145.6, -15.45, 0]) cube([0.4, 30.9, 27.81]);
    }
    hull() {
      translate([145.6, -15.45, 0]) cube([0.4, 30.9, 27.81]);
      translate([160, -13, 0]) cube([0.4, 26, 23.4]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -11.4, 4]) cube([0.4, 22.8, 17.8]);
    translate([9.4, -13.36, 4]) cube([0.4, 26.72, 21.72]);
  }
  hull() {
    translate([9.4, -13.36, 4]) cube([0.4, 26.72, 21.72]);
    translate([75, -17, 4]) cube([0.4, 34, 29]);
  }
  hull() {
    translate([75, -17, 4]) cube([0.4, 34, 29]);
    translate([140.6, -13.36, 4]) cube([0.4, 26.72, 21.72]);
  }
  hull() {
    translate([140.6, -13.36, 4]) cube([0.4, 26.72, 21.72]);
    translate([165, -11.4, 4]) cube([0.4, 22.8, 17.8]);
  }
}
