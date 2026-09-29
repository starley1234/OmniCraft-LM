$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 140 x 46 x 30 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 140;             // channel length
width = 46;               // channel width at mid length
height = 30;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 4;              // floor thickness
end_w = 32.2;             // faired end width
end_h = 21;               // faired end height
ribs = 3;                 // stiffening ribs on the top
rib_t = 3;                // rib thickness
rib_h = 3;                // rib height

difference() {
  union() {
    hull() {
      translate([0, -16.1, 0]) cube([0.4, 32.2, 21]);
      translate([12.6, -23, 0]) cube([0.4, 46, 30]);
    }
    hull() {
      translate([12.6, -23, 0]) cube([0.4, 46, 30]);
      translate([70, -23, 0]) cube([0.4, 46, 30]);
    }
    hull() {
      translate([70, -23, 0]) cube([0.4, 46, 30]);
      translate([127.4, -23, 0]) cube([0.4, 46, 30]);
    }
    hull() {
      translate([127.4, -23, 0]) cube([0.4, 46, 30]);
      translate([140, -16.1, 0]) cube([0.4, 32.2, 21]);
    }
    /* stiffening ribs across the flat top, sunk 0.8 mm into it */
    for (i = [1 : ribs]) {
      translate([12.6 + i * (length - 2 * 12.6) / (ribs + 1) - rib_t / 2, -width / 2, height - 0.8]) cube([rib_t, width, rib_h + 0.8]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -14.5, 4]) cube([0.4, 29, 15.4]);
    translate([7.6, -16.25, 4]) cube([0.4, 32.5, 17.89]);
  }
  hull() {
    translate([7.6, -16.25, 4]) cube([0.4, 32.5, 17.89]);
    translate([65, -19.5, 4]) cube([0.4, 39, 22.5]);
  }
  hull() {
    translate([65, -19.5, 4]) cube([0.4, 39, 22.5]);
    translate([122.4, -16.25, 4]) cube([0.4, 32.5, 17.89]);
  }
  hull() {
    translate([122.4, -16.25, 4]) cube([0.4, 32.5, 17.89]);
    translate([145, -14.5, 4]) cube([0.4, 29, 15.4]);
  }
}
