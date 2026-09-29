$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 180 x 58 x 36 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 180;             // channel length
width = 58;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 34.8;             // faired end width
end_h = 21.6;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -17.4, 0]) cube([0.4, 34.8, 21.6]);
      translate([16.2, -21.46, 0]) cube([0.4, 42.92, 26.64]);
    }
    hull() {
      translate([16.2, -21.46, 0]) cube([0.4, 42.92, 26.64]);
      translate([90, -29, 0]) cube([0.4, 58, 36]);
    }
    hull() {
      translate([90, -29, 0]) cube([0.4, 58, 36]);
      translate([163.8, -21.46, 0]) cube([0.4, 42.92, 26.64]);
    }
    hull() {
      translate([163.8, -21.46, 0]) cube([0.4, 42.92, 26.64]);
      translate([180, -17.4, 0]) cube([0.4, 34.8, 21.6]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -15.8, 4]) cube([0.4, 31.6, 16]);
    translate([11.2, -19.37, 4]) cube([0.4, 38.74, 20.55]);
  }
  hull() {
    translate([11.2, -19.37, 4]) cube([0.4, 38.74, 20.55]);
    translate([85, -26, 4]) cube([0.4, 52, 29]);
  }
  hull() {
    translate([85, -26, 4]) cube([0.4, 52, 29]);
    translate([158.8, -19.37, 4]) cube([0.4, 38.74, 20.55]);
  }
  hull() {
    translate([158.8, -19.37, 4]) cube([0.4, 38.74, 20.55]);
    translate([185, -15.8, 4]) cube([0.4, 31.6, 16]);
  }
}
