$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 140 x 40 x 36 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 140;             // channel length
width = 40;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 3;              // floor thickness
end_w = 24;               // faired end width
end_h = 21.6;             // faired end height
ribs = 5;                 // stiffening ribs on the top
rib_t = 2.4;              // rib thickness
rib_h = 4;                // rib height

difference() {
  union() {
    hull() {
      translate([0, -12, 0]) cube([0.4, 24, 21.6]);
      translate([12.6, -20, 0]) cube([0.4, 40, 36]);
    }
    hull() {
      translate([12.6, -20, 0]) cube([0.4, 40, 36]);
      translate([70, -20, 0]) cube([0.4, 40, 36]);
    }
    hull() {
      translate([70, -20, 0]) cube([0.4, 40, 36]);
      translate([127.4, -20, 0]) cube([0.4, 40, 36]);
    }
    hull() {
      translate([127.4, -20, 0]) cube([0.4, 40, 36]);
      translate([140, -12, 0]) cube([0.4, 24, 21.6]);
    }
    /* stiffening ribs across the flat top, sunk 0.8 mm into it */
    for (i = [1 : ribs]) {
      translate([12.6 + i * (length - 2 * 12.6) / (ribs + 1) - rib_t / 2, -width / 2, height - 0.8]) cube([rib_t, width, rib_h + 0.8]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -10.4, 3]) cube([0.4, 20.8, 17]);
    translate([7.6, -12.535, 3]) cube([0.4, 25.07, 21.38]);
  }
  hull() {
    translate([7.6, -12.535, 3]) cube([0.4, 25.07, 21.38]);
    translate([65, -16.5, 3]) cube([0.4, 33, 29.5]);
  }
  hull() {
    translate([65, -16.5, 3]) cube([0.4, 33, 29.5]);
    translate([122.4, -12.535, 3]) cube([0.4, 25.07, 21.38]);
  }
  hull() {
    translate([122.4, -12.535, 3]) cube([0.4, 25.07, 21.38]);
    translate([145, -10.4, 3]) cube([0.4, 20.8, 17]);
  }
}
