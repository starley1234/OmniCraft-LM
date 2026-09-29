$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 180 x 40 x 36 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 180;             // channel length
width = 40;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 24;               // faired end width
end_h = 21.6;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -12, 0]) cube([0.4, 24, 21.6]);
      translate([16.2, -14.8, 0]) cube([0.4, 29.6, 26.64]);
    }
    hull() {
      translate([16.2, -14.8, 0]) cube([0.4, 29.6, 26.64]);
      translate([90, -20, 0]) cube([0.4, 40, 36]);
    }
    hull() {
      translate([90, -20, 0]) cube([0.4, 40, 36]);
      translate([163.8, -14.8, 0]) cube([0.4, 29.6, 26.64]);
    }
    hull() {
      translate([163.8, -14.8, 0]) cube([0.4, 29.6, 26.64]);
      translate([180, -12, 0]) cube([0.4, 24, 21.6]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -10.4, 4]) cube([0.4, 20.8, 16]);
    translate([11.2, -12.71, 4]) cube([0.4, 25.42, 20.55]);
  }
  hull() {
    translate([11.2, -12.71, 4]) cube([0.4, 25.42, 20.55]);
    translate([85, -17, 4]) cube([0.4, 34, 29]);
  }
  hull() {
    translate([85, -17, 4]) cube([0.4, 34, 29]);
    translate([158.8, -12.71, 4]) cube([0.4, 25.42, 20.55]);
  }
  hull() {
    translate([158.8, -12.71, 4]) cube([0.4, 25.42, 20.55]);
    translate([185, -10.4, 4]) cube([0.4, 20.8, 16]);
  }
}
