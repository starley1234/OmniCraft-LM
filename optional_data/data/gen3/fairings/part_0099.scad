$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 180 x 52 x 30 mm, 4 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 180;             // channel length
width = 52;               // channel width at mid length
height = 30;              // channel height at mid length
wall = 4;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 36.4;             // faired end width
end_h = 21;               // faired end height
ribs = 4;                 // stiffening ribs on the top
rib_t = 3;                // rib thickness
rib_h = 3;                // rib height

difference() {
  union() {
    hull() {
      translate([0, -18.2, 0]) cube([0.4, 36.4, 21]);
      translate([16.2, -26, 0]) cube([0.4, 52, 30]);
    }
    hull() {
      translate([16.2, -26, 0]) cube([0.4, 52, 30]);
      translate([90, -26, 0]) cube([0.4, 52, 30]);
    }
    hull() {
      translate([90, -26, 0]) cube([0.4, 52, 30]);
      translate([163.8, -26, 0]) cube([0.4, 52, 30]);
    }
    hull() {
      translate([163.8, -26, 0]) cube([0.4, 52, 30]);
      translate([180, -18.2, 0]) cube([0.4, 36.4, 21]);
    }
    /* stiffening ribs across the flat top, sunk 0.8 mm into it */
    for (i = [1 : ribs]) {
      translate([16.2 + i * (length - 2 * 16.2) / (ribs + 1) - rib_t / 2, -width / 2, height - 0.8]) cube([rib_t, width, rib_h + 0.8]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -16.6, 4]) cube([0.4, 33.2, 15.4]);
    translate([11.2, -18.49, 4]) cube([0.4, 36.98, 17.71]);
  }
  hull() {
    translate([11.2, -18.49, 4]) cube([0.4, 36.98, 17.71]);
    translate([85, -22, 4]) cube([0.4, 44, 22]);
  }
  hull() {
    translate([85, -22, 4]) cube([0.4, 44, 22]);
    translate([158.8, -18.49, 4]) cube([0.4, 36.98, 17.71]);
  }
  hull() {
    translate([158.8, -18.49, 4]) cube([0.4, 36.98, 17.71]);
    translate([185, -16.6, 4]) cube([0.4, 33.2, 15.4]);
  }
}
