$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 180 x 46 x 30 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 180;             // channel length
width = 46;               // channel width at mid length
height = 30;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 3;              // floor thickness
end_w = 27.6;             // faired end width
end_h = 18;               // faired end height

difference() {
  union() {
    hull() {
      translate([0, -13.8, 0]) cube([0.4, 27.6, 18]);
      translate([16.2, -17.02, 0]) cube([0.4, 34.04, 22.2]);
    }
    hull() {
      translate([16.2, -17.02, 0]) cube([0.4, 34.04, 22.2]);
      translate([90, -23, 0]) cube([0.4, 46, 30]);
    }
    hull() {
      translate([90, -23, 0]) cube([0.4, 46, 30]);
      translate([163.8, -17.02, 0]) cube([0.4, 34.04, 22.2]);
    }
    hull() {
      translate([163.8, -17.02, 0]) cube([0.4, 34.04, 22.2]);
      translate([180, -13.8, 0]) cube([0.4, 27.6, 18]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -12.2, 3]) cube([0.4, 24.4, 13.4]);
    translate([11.2, -14.755, 3]) cube([0.4, 29.51, 16.93]);
  }
  hull() {
    translate([11.2, -14.755, 3]) cube([0.4, 29.51, 16.93]);
    translate([85, -19.5, 3]) cube([0.4, 39, 23.5]);
  }
  hull() {
    translate([85, -19.5, 3]) cube([0.4, 39, 23.5]);
    translate([158.8, -14.755, 3]) cube([0.4, 29.51, 16.93]);
  }
  hull() {
    translate([158.8, -14.755, 3]) cube([0.4, 29.51, 16.93]);
    translate([185, -12.2, 3]) cube([0.4, 24.4, 13.4]);
  }
}
