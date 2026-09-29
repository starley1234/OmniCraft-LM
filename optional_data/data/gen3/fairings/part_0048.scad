$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 140 x 58 x 36 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 140;             // channel length
width = 58;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 4;              // floor thickness
end_w = 40.6;             // faired end width
end_h = 25.2;             // faired end height
ribs = 3;                 // stiffening ribs on the top
rib_t = 2.4;              // rib thickness
rib_h = 4;                // rib height

difference() {
  union() {
    hull() {
      translate([0, -20.3, 0]) cube([0.4, 40.6, 25.2]);
      translate([12.6, -29, 0]) cube([0.4, 58, 36]);
    }
    hull() {
      translate([12.6, -29, 0]) cube([0.4, 58, 36]);
      translate([70, -29, 0]) cube([0.4, 58, 36]);
    }
    hull() {
      translate([70, -29, 0]) cube([0.4, 58, 36]);
      translate([127.4, -29, 0]) cube([0.4, 58, 36]);
    }
    hull() {
      translate([127.4, -29, 0]) cube([0.4, 58, 36]);
      translate([140, -20.3, 0]) cube([0.4, 40.6, 25.2]);
    }
    /* stiffening ribs across the flat top, sunk 0.8 mm into it */
    for (i = [1 : ribs]) {
      translate([12.6 + i * (length - 2 * 12.6) / (ribs + 1) - rib_t / 2, -width / 2, height - 0.8]) cube([rib_t, width, rib_h + 0.8]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -18.7, 4]) cube([0.4, 37.4, 19.6]);
    translate([7.6, -21.08, 4]) cube([0.4, 42.16, 22.71]);
  }
  hull() {
    translate([7.6, -21.08, 4]) cube([0.4, 42.16, 22.71]);
    translate([65, -25.5, 4]) cube([0.4, 51, 28.5]);
  }
  hull() {
    translate([65, -25.5, 4]) cube([0.4, 51, 28.5]);
    translate([122.4, -21.08, 4]) cube([0.4, 42.16, 22.71]);
  }
  hull() {
    translate([122.4, -21.08, 4]) cube([0.4, 42.16, 22.71]);
    translate([145, -18.7, 4]) cube([0.4, 37.4, 19.6]);
  }
}
