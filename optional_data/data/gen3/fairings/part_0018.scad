$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 140 x 46 x 26 mm, 4 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 140;             // channel length
width = 46;               // channel width at mid length
height = 26;              // channel height at mid length
wall = 4;                 // side wall thickness
floor_t = 3;              // floor thickness
end_w = 29.9;             // faired end width
end_h = 16.9;             // faired end height
ribs = 4;                 // stiffening ribs on the top
rib_t = 2.4;              // rib thickness
rib_h = 3;                // rib height

difference() {
  union() {
    hull() {
      translate([0, -14.95, 0]) cube([0.4, 29.9, 16.9]);
      translate([12.6, -23, 0]) cube([0.4, 46, 26]);
    }
    hull() {
      translate([12.6, -23, 0]) cube([0.4, 46, 26]);
      translate([70, -23, 0]) cube([0.4, 46, 26]);
    }
    hull() {
      translate([70, -23, 0]) cube([0.4, 46, 26]);
      translate([127.4, -23, 0]) cube([0.4, 46, 26]);
    }
    hull() {
      translate([127.4, -23, 0]) cube([0.4, 46, 26]);
      translate([140, -14.95, 0]) cube([0.4, 29.9, 16.9]);
    }
    /* stiffening ribs across the flat top, sunk 0.8 mm into it */
    for (i = [1 : ribs]) {
      translate([12.6 + i * (length - 2 * 12.6) / (ribs + 1) - rib_t / 2, -width / 2, height - 0.8]) cube([rib_t, width, rib_h + 0.8]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -13.35, 3]) cube([0.4, 26.7, 12.3]);
    translate([7.6, -15.33, 3]) cube([0.4, 30.66, 14.64]);
  }
  hull() {
    translate([7.6, -15.33, 3]) cube([0.4, 30.66, 14.64]);
    translate([65, -19, 3]) cube([0.4, 38, 19]);
  }
  hull() {
    translate([65, -19, 3]) cube([0.4, 38, 19]);
    translate([122.4, -15.33, 3]) cube([0.4, 30.66, 14.64]);
  }
  hull() {
    translate([122.4, -15.33, 3]) cube([0.4, 30.66, 14.64]);
    translate([145, -13.35, 3]) cube([0.4, 26.7, 12.3]);
  }
}
