$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 160 x 40 x 36 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 160;             // channel length
width = 40;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 3;              // floor thickness
end_w = 28;               // faired end width
end_h = 25.2;             // faired end height
ribs = 4;                 // stiffening ribs on the top
rib_t = 3;                // rib thickness
rib_h = 4;                // rib height

difference() {
  union() {
    hull() {
      translate([0, -14, 0]) cube([0.4, 28, 25.2]);
      translate([14.4, -20, 0]) cube([0.4, 40, 36]);
    }
    hull() {
      translate([14.4, -20, 0]) cube([0.4, 40, 36]);
      translate([80, -20, 0]) cube([0.4, 40, 36]);
    }
    hull() {
      translate([80, -20, 0]) cube([0.4, 40, 36]);
      translate([145.6, -20, 0]) cube([0.4, 40, 36]);
    }
    hull() {
      translate([145.6, -20, 0]) cube([0.4, 40, 36]);
      translate([160, -14, 0]) cube([0.4, 28, 25.2]);
    }
    /* stiffening ribs across the flat top, sunk 0.8 mm into it */
    for (i = [1 : ribs]) {
      translate([14.4 + i * (length - 2 * 14.4) / (ribs + 1) - rib_t / 2, -width / 2, height - 0.8]) cube([rib_t, width, rib_h + 0.8]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -12.4, 3]) cube([0.4, 24.8, 20.6]);
    translate([9.4, -13.835, 3]) cube([0.4, 27.67, 23.71]);
  }
  hull() {
    translate([9.4, -13.835, 3]) cube([0.4, 27.67, 23.71]);
    translate([75, -16.5, 3]) cube([0.4, 33, 29.5]);
  }
  hull() {
    translate([75, -16.5, 3]) cube([0.4, 33, 29.5]);
    translate([140.6, -13.835, 3]) cube([0.4, 27.67, 23.71]);
  }
  hull() {
    translate([140.6, -13.835, 3]) cube([0.4, 27.67, 23.71]);
    translate([165, -12.4, 3]) cube([0.4, 24.8, 20.6]);
  }
}
