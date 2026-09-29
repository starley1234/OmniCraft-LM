$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 180 x 58 x 26 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 180;             // channel length
width = 58;               // channel width at mid length
height = 26;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 3;              // floor thickness
end_w = 34.8;             // faired end width
end_h = 15.6;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -17.4, 0]) cube([0.4, 34.8, 15.6]);
      translate([16.2, -21.46, 0]) cube([0.4, 42.92, 19.24]);
    }
    hull() {
      translate([16.2, -21.46, 0]) cube([0.4, 42.92, 19.24]);
      translate([90, -29, 0]) cube([0.4, 58, 26]);
    }
    hull() {
      translate([90, -29, 0]) cube([0.4, 58, 26]);
      translate([163.8, -21.46, 0]) cube([0.4, 42.92, 19.24]);
    }
    hull() {
      translate([163.8, -21.46, 0]) cube([0.4, 42.92, 19.24]);
      translate([180, -17.4, 0]) cube([0.4, 34.8, 15.6]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -15.8, 3]) cube([0.4, 31.6, 11]);
    translate([11.2, -19.195, 3]) cube([0.4, 38.39, 13.97]);
  }
  hull() {
    translate([11.2, -19.195, 3]) cube([0.4, 38.39, 13.97]);
    translate([85, -25.5, 3]) cube([0.4, 51, 19.5]);
  }
  hull() {
    translate([85, -25.5, 3]) cube([0.4, 51, 19.5]);
    translate([158.8, -19.195, 3]) cube([0.4, 38.39, 13.97]);
  }
  hull() {
    translate([158.8, -19.195, 3]) cube([0.4, 38.39, 13.97]);
    translate([185, -15.8, 3]) cube([0.4, 31.6, 11]);
  }
}
