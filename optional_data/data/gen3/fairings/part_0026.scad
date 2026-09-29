$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 180 x 40 x 36 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 180;             // channel length
width = 40;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 3;              // floor thickness
end_w = 26;               // faired end width
end_h = 23.4;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -13, 0]) cube([0.4, 26, 23.4]);
      translate([16.2, -15.45, 0]) cube([0.4, 30.9, 27.81]);
    }
    hull() {
      translate([16.2, -15.45, 0]) cube([0.4, 30.9, 27.81]);
      translate([90, -20, 0]) cube([0.4, 40, 36]);
    }
    hull() {
      translate([90, -20, 0]) cube([0.4, 40, 36]);
      translate([163.8, -15.45, 0]) cube([0.4, 30.9, 27.81]);
    }
    hull() {
      translate([163.8, -15.45, 0]) cube([0.4, 30.9, 27.81]);
      translate([180, -13, 0]) cube([0.4, 26, 23.4]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -11.4, 3]) cube([0.4, 22.8, 18.8]);
    translate([11.2, -13.36, 3]) cube([0.4, 26.72, 22.72]);
  }
  hull() {
    translate([11.2, -13.36, 3]) cube([0.4, 26.72, 22.72]);
    translate([85, -17, 3]) cube([0.4, 34, 30]);
  }
  hull() {
    translate([85, -17, 3]) cube([0.4, 34, 30]);
    translate([158.8, -13.36, 3]) cube([0.4, 26.72, 22.72]);
  }
  hull() {
    translate([158.8, -13.36, 3]) cube([0.4, 26.72, 22.72]);
    translate([185, -11.4, 3]) cube([0.4, 22.8, 18.8]);
  }
}
