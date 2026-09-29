$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 180 x 40 x 26 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 180;             // channel length
width = 40;               // channel width at mid length
height = 26;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 3;              // floor thickness
end_w = 28;               // faired end width
end_h = 18.2;             // faired end height
ribs = 3;                 // stiffening ribs on the top
rib_t = 3;                // rib thickness
rib_h = 4;                // rib height

difference() {
  union() {
    hull() {
      translate([0, -14, 0]) cube([0.4, 28, 18.2]);
      translate([16.2, -20, 0]) cube([0.4, 40, 26]);
    }
    hull() {
      translate([16.2, -20, 0]) cube([0.4, 40, 26]);
      translate([90, -20, 0]) cube([0.4, 40, 26]);
    }
    hull() {
      translate([90, -20, 0]) cube([0.4, 40, 26]);
      translate([163.8, -20, 0]) cube([0.4, 40, 26]);
    }
    hull() {
      translate([163.8, -20, 0]) cube([0.4, 40, 26]);
      translate([180, -14, 0]) cube([0.4, 28, 18.2]);
    }
    /* stiffening ribs across the flat top, sunk 0.8 mm into it */
    for (i = [1 : ribs]) {
      translate([16.2 + i * (length - 2 * 16.2) / (ribs + 1) - rib_t / 2, -width / 2, height - 0.8]) cube([rib_t, width, rib_h + 0.8]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -12.4, 3]) cube([0.4, 24.8, 13.6]);
    translate([11.2, -13.835, 3]) cube([0.4, 27.67, 15.66]);
  }
  hull() {
    translate([11.2, -13.835, 3]) cube([0.4, 27.67, 15.66]);
    translate([85, -16.5, 3]) cube([0.4, 33, 19.5]);
  }
  hull() {
    translate([85, -16.5, 3]) cube([0.4, 33, 19.5]);
    translate([158.8, -13.835, 3]) cube([0.4, 27.67, 15.66]);
  }
  hull() {
    translate([158.8, -13.835, 3]) cube([0.4, 27.67, 15.66]);
    translate([185, -12.4, 3]) cube([0.4, 24.8, 13.6]);
  }
}
