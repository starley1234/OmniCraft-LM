$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 180 x 52 x 42 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 180;             // channel length
width = 52;               // channel width at mid length
height = 42;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 3;              // floor thickness
end_w = 33.8;             // faired end width
end_h = 27.3;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -16.9, 0]) cube([0.4, 33.8, 27.3]);
      translate([16.2, -20.085, 0]) cube([0.4, 40.17, 32.45]);
    }
    hull() {
      translate([16.2, -20.085, 0]) cube([0.4, 40.17, 32.45]);
      translate([90, -26, 0]) cube([0.4, 52, 42]);
    }
    hull() {
      translate([90, -26, 0]) cube([0.4, 52, 42]);
      translate([163.8, -20.085, 0]) cube([0.4, 40.17, 32.45]);
    }
    hull() {
      translate([163.8, -20.085, 0]) cube([0.4, 40.17, 32.45]);
      translate([180, -16.9, 0]) cube([0.4, 33.8, 27.3]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -15.3, 3]) cube([0.4, 30.6, 22.7]);
    translate([11.2, -17.82, 3]) cube([0.4, 35.64, 27.18]);
  }
  hull() {
    translate([11.2, -17.82, 3]) cube([0.4, 35.64, 27.18]);
    translate([85, -22.5, 3]) cube([0.4, 45, 35.5]);
  }
  hull() {
    translate([85, -22.5, 3]) cube([0.4, 45, 35.5]);
    translate([158.8, -17.82, 3]) cube([0.4, 35.64, 27.18]);
  }
  hull() {
    translate([158.8, -17.82, 3]) cube([0.4, 35.64, 27.18]);
    translate([185, -15.3, 3]) cube([0.4, 30.6, 22.7]);
  }
}
