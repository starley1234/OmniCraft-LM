$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 180 x 46 x 26 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 180;             // channel length
width = 46;               // channel width at mid length
height = 26;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 4;              // floor thickness
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
    translate([-5, -13.35, 4]) cube([0.4, 26.7, 11.3]);
    translate([11.2, -15.5, 4]) cube([0.4, 31, 13.82]);
  }
  hull() {
    translate([11.2, -15.5, 4]) cube([0.4, 31, 13.82]);
    translate([85, -19.5, 4]) cube([0.4, 39, 18.5]);
  }
  hull() {
    translate([85, -19.5, 4]) cube([0.4, 39, 18.5]);
    translate([158.8, -15.5, 4]) cube([0.4, 31, 13.82]);
  }
  hull() {
    translate([158.8, -15.5, 4]) cube([0.4, 31, 13.82]);
    translate([185, -13.35, 4]) cube([0.4, 26.7, 11.3]);
  }
}
