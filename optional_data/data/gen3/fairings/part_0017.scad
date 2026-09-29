$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 40 x 42 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 40;               // channel width at mid length
height = 42;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 4;              // floor thickness
end_w = 28;               // faired end width
end_h = 29.4;             // faired end height
ribs = 4;                 // stiffening ribs on the top
rib_t = 2.4;              // rib thickness
rib_h = 4;                // rib height

difference() {
  union() {
    hull() {
      translate([0, -14, 0]) cube([0.4, 28, 29.4]);
      translate([18, -20, 0]) cube([0.4, 40, 42]);
    }
    hull() {
      translate([18, -20, 0]) cube([0.4, 40, 42]);
      translate([100, -20, 0]) cube([0.4, 40, 42]);
    }
    hull() {
      translate([100, -20, 0]) cube([0.4, 40, 42]);
      translate([182, -20, 0]) cube([0.4, 40, 42]);
    }
    hull() {
      translate([182, -20, 0]) cube([0.4, 40, 42]);
      translate([200, -14, 0]) cube([0.4, 28, 29.4]);
    }
    /* stiffening ribs across the flat top, sunk 0.8 mm into it */
    for (i = [1 : ribs]) {
      translate([18 + i * (length - 2 * 18) / (ribs + 1) - rib_t / 2, -width / 2, height - 0.8]) cube([rib_t, width, rib_h + 0.8]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -12.4, 4]) cube([0.4, 24.8, 23.8]);
    translate([13, -13.835, 4]) cube([0.4, 27.67, 27.55]);
  }
  hull() {
    translate([13, -13.835, 4]) cube([0.4, 27.67, 27.55]);
    translate([95, -16.5, 4]) cube([0.4, 33, 34.5]);
  }
  hull() {
    translate([95, -16.5, 4]) cube([0.4, 33, 34.5]);
    translate([177, -13.835, 4]) cube([0.4, 27.67, 27.55]);
  }
  hull() {
    translate([177, -13.835, 4]) cube([0.4, 27.67, 27.55]);
    translate([205, -12.4, 4]) cube([0.4, 24.8, 23.8]);
  }
}
