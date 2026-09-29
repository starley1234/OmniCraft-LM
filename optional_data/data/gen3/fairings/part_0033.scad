$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 140 x 58 x 26 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 140;             // channel length
width = 58;               // channel width at mid length
height = 26;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 4;              // floor thickness
end_w = 34.8;             // faired end width
end_h = 15.6;             // faired end height
ribs = 5;                 // stiffening ribs on the top
rib_t = 2.4;              // rib thickness
rib_h = 3;                // rib height

difference() {
  union() {
    hull() {
      translate([0, -17.4, 0]) cube([0.4, 34.8, 15.6]);
      translate([12.6, -29, 0]) cube([0.4, 58, 26]);
    }
    hull() {
      translate([12.6, -29, 0]) cube([0.4, 58, 26]);
      translate([70, -29, 0]) cube([0.4, 58, 26]);
    }
    hull() {
      translate([70, -29, 0]) cube([0.4, 58, 26]);
      translate([127.4, -29, 0]) cube([0.4, 58, 26]);
    }
    hull() {
      translate([127.4, -29, 0]) cube([0.4, 58, 26]);
      translate([140, -17.4, 0]) cube([0.4, 34.8, 15.6]);
    }
    /* stiffening ribs across the flat top, sunk 0.8 mm into it */
    for (i = [1 : ribs]) {
      translate([12.6 + i * (length - 2 * 12.6) / (ribs + 1) - rib_t / 2, -width / 2, height - 0.8]) cube([rib_t, width, rib_h + 0.8]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -15.8, 4]) cube([0.4, 31.6, 10]);
    translate([7.6, -19.195, 4]) cube([0.4, 38.39, 12.97]);
  }
  hull() {
    translate([7.6, -19.195, 4]) cube([0.4, 38.39, 12.97]);
    translate([65, -25.5, 4]) cube([0.4, 51, 18.5]);
  }
  hull() {
    translate([65, -25.5, 4]) cube([0.4, 51, 18.5]);
    translate([122.4, -19.195, 4]) cube([0.4, 38.39, 12.97]);
  }
  hull() {
    translate([122.4, -19.195, 4]) cube([0.4, 38.39, 12.97]);
    translate([145, -15.8, 4]) cube([0.4, 31.6, 10]);
  }
}
