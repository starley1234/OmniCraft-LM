$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 180 x 46 x 26 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 180;             // channel length
width = 46;               // channel width at mid length
height = 26;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 3;              // floor thickness
end_w = 29.9;             // faired end width
end_h = 16.9;             // faired end height

difference() {
  union() {
    hull() {
      translate([0, -14.95, 0]) cube([0.4, 29.9, 16.9]);
      translate([16.2, -17.765, 0]) cube([0.4, 35.53, 20.09]);
    }
    hull() {
      translate([16.2, -17.765, 0]) cube([0.4, 35.53, 20.09]);
      translate([90, -23, 0]) cube([0.4, 46, 26]);
    }
    hull() {
      translate([90, -23, 0]) cube([0.4, 46, 26]);
      translate([163.8, -17.765, 0]) cube([0.4, 35.53, 20.09]);
    }
    hull() {
      translate([163.8, -17.765, 0]) cube([0.4, 35.53, 20.09]);
      translate([180, -14.95, 0]) cube([0.4, 29.9, 16.9]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -13.35, 3]) cube([0.4, 26.7, 12.3]);
    translate([11.2, -15.68, 3]) cube([0.4, 31.36, 15]);
  }
  hull() {
    translate([11.2, -15.68, 3]) cube([0.4, 31.36, 15]);
    translate([85, -20, 3]) cube([0.4, 40, 20]);
  }
  hull() {
    translate([85, -20, 3]) cube([0.4, 40, 20]);
    translate([158.8, -15.68, 3]) cube([0.4, 31.36, 15]);
  }
  hull() {
    translate([158.8, -15.68, 3]) cube([0.4, 31.36, 15]);
    translate([185, -13.35, 3]) cube([0.4, 26.7, 12.3]);
  }
}
