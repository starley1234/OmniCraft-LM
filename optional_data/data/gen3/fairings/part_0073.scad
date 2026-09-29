$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 180 x 46 x 42 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 180;             // channel length
width = 46;               // channel width at mid length
height = 42;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 4;              // floor thickness
end_w = 32.2;             // faired end width
end_h = 29.4;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -16.1, 0]) cube([0.4, 32.2, 29.4]);
      translate([16.2, -18.515, 0]) cube([0.4, 37.03, 33.81]);
    }
    hull() {
      translate([16.2, -18.515, 0]) cube([0.4, 37.03, 33.81]);
      translate([90, -23, 0]) cube([0.4, 46, 42]);
    }
    hull() {
      translate([90, -23, 0]) cube([0.4, 46, 42]);
      translate([163.8, -18.515, 0]) cube([0.4, 37.03, 33.81]);
    }
    hull() {
      translate([163.8, -18.515, 0]) cube([0.4, 37.03, 33.81]);
      translate([180, -16.1, 0]) cube([0.4, 32.2, 29.4]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -14.5, 4]) cube([0.4, 29, 23.8]);
    translate([11.2, -16.25, 4]) cube([0.4, 32.5, 27.55]);
  }
  hull() {
    translate([11.2, -16.25, 4]) cube([0.4, 32.5, 27.55]);
    translate([85, -19.5, 4]) cube([0.4, 39, 34.5]);
  }
  hull() {
    translate([85, -19.5, 4]) cube([0.4, 39, 34.5]);
    translate([158.8, -16.25, 4]) cube([0.4, 32.5, 27.55]);
  }
  hull() {
    translate([158.8, -16.25, 4]) cube([0.4, 32.5, 27.55]);
    translate([185, -14.5, 4]) cube([0.4, 29, 23.8]);
  }
}
