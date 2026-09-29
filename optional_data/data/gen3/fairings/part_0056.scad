$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 180 x 52 x 30 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 180;             // channel length
width = 52;               // channel width at mid length
height = 30;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 3;              // floor thickness
end_w = 36.4;             // faired end width
end_h = 21;               // faired end height

difference() {
  union() {
    hull() {
      translate([0, -18.2, 0]) cube([0.4, 36.4, 21]);
      translate([16.2, -20.93, 0]) cube([0.4, 41.86, 24.15]);
    }
    hull() {
      translate([16.2, -20.93, 0]) cube([0.4, 41.86, 24.15]);
      translate([90, -26, 0]) cube([0.4, 52, 30]);
    }
    hull() {
      translate([90, -26, 0]) cube([0.4, 52, 30]);
      translate([163.8, -20.93, 0]) cube([0.4, 41.86, 24.15]);
    }
    hull() {
      translate([163.8, -20.93, 0]) cube([0.4, 41.86, 24.15]);
      translate([180, -18.2, 0]) cube([0.4, 36.4, 21]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -16.6, 3]) cube([0.4, 33.2, 16.4]);
    translate([11.2, -18.84, 3]) cube([0.4, 37.68, 19.06]);
  }
  hull() {
    translate([11.2, -18.84, 3]) cube([0.4, 37.68, 19.06]);
    translate([85, -23, 3]) cube([0.4, 46, 24]);
  }
  hull() {
    translate([85, -23, 3]) cube([0.4, 46, 24]);
    translate([158.8, -18.84, 3]) cube([0.4, 37.68, 19.06]);
  }
  hull() {
    translate([158.8, -18.84, 3]) cube([0.4, 37.68, 19.06]);
    translate([185, -16.6, 3]) cube([0.4, 33.2, 16.4]);
  }
}
