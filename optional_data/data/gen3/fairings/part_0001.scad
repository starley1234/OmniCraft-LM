$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 180 x 46 x 42 mm, 4 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 180;             // channel length
width = 46;               // channel width at mid length
height = 42;              // channel height at mid length
wall = 4;                 // side wall thickness
floor_t = 3;              // floor thickness
end_w = 29.9;             // faired end width
end_h = 27.3;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -14.95, 0]) cube([0.4, 29.9, 27.3]);
      translate([16.2, -17.765, 0]) cube([0.4, 35.53, 32.45]);
    }
    hull() {
      translate([16.2, -17.765, 0]) cube([0.4, 35.53, 32.45]);
      translate([90, -23, 0]) cube([0.4, 46, 42]);
    }
    hull() {
      translate([90, -23, 0]) cube([0.4, 46, 42]);
      translate([163.8, -17.765, 0]) cube([0.4, 35.53, 32.45]);
    }
    hull() {
      translate([163.8, -17.765, 0]) cube([0.4, 35.53, 32.45]);
      translate([180, -14.95, 0]) cube([0.4, 29.9, 27.3]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -13.35, 3]) cube([0.4, 26.7, 22.7]);
    translate([11.2, -15.33, 3]) cube([0.4, 30.66, 27]);
  }
  hull() {
    translate([11.2, -15.33, 3]) cube([0.4, 30.66, 27]);
    translate([85, -19, 3]) cube([0.4, 38, 35]);
  }
  hull() {
    translate([85, -19, 3]) cube([0.4, 38, 35]);
    translate([158.8, -15.33, 3]) cube([0.4, 30.66, 27]);
  }
  hull() {
    translate([158.8, -15.33, 3]) cube([0.4, 30.66, 27]);
    translate([185, -13.35, 3]) cube([0.4, 26.7, 22.7]);
  }
}
