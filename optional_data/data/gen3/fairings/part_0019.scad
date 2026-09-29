$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 140 x 52 x 30 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 140;             // channel length
width = 52;               // channel width at mid length
height = 30;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 36.4;             // faired end width
end_h = 21;               // faired end height
ribs = 3;                 // stiffening ribs on the top
rib_t = 3;                // rib thickness
rib_h = 3;                // rib height

difference() {
  union() {
    hull() {
      translate([0, -18.2, 0]) cube([0.4, 36.4, 21]);
      translate([12.6, -26, 0]) cube([0.4, 52, 30]);
    }
    hull() {
      translate([12.6, -26, 0]) cube([0.4, 52, 30]);
      translate([70, -26, 0]) cube([0.4, 52, 30]);
    }
    hull() {
      translate([70, -26, 0]) cube([0.4, 52, 30]);
      translate([127.4, -26, 0]) cube([0.4, 52, 30]);
    }
    hull() {
      translate([127.4, -26, 0]) cube([0.4, 52, 30]);
      translate([140, -18.2, 0]) cube([0.4, 36.4, 21]);
    }
    /* stiffening ribs across the flat top, sunk 0.8 mm into it */
    for (i = [1 : ribs]) {
      translate([12.6 + i * (length - 2 * 12.6) / (ribs + 1) - rib_t / 2, -width / 2, height - 0.8]) cube([rib_t, width, rib_h + 0.8]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -16.6, 4]) cube([0.4, 33.2, 15.4]);
    translate([7.6, -18.84, 4]) cube([0.4, 37.68, 18.06]);
  }
  hull() {
    translate([7.6, -18.84, 4]) cube([0.4, 37.68, 18.06]);
    translate([65, -23, 4]) cube([0.4, 46, 23]);
  }
  hull() {
    translate([65, -23, 4]) cube([0.4, 46, 23]);
    translate([122.4, -18.84, 4]) cube([0.4, 37.68, 18.06]);
  }
  hull() {
    translate([122.4, -18.84, 4]) cube([0.4, 37.68, 18.06]);
    translate([145, -16.6, 4]) cube([0.4, 33.2, 15.4]);
  }
}
