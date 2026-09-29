$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 160 x 40 x 30 mm, 4 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 160;             // channel length
width = 40;               // channel width at mid length
height = 30;              // channel height at mid length
wall = 4;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 26;               // faired end width
end_h = 19.5;             // faired end height
ribs = 4;                 // stiffening ribs on the top
rib_t = 3;                // rib thickness
rib_h = 4;                // rib height

difference() {
  union() {
    hull() {
      translate([0, -13, 0]) cube([0.4, 26, 19.5]);
      translate([14.4, -20, 0]) cube([0.4, 40, 30]);
    }
    hull() {
      translate([14.4, -20, 0]) cube([0.4, 40, 30]);
      translate([80, -20, 0]) cube([0.4, 40, 30]);
    }
    hull() {
      translate([80, -20, 0]) cube([0.4, 40, 30]);
      translate([145.6, -20, 0]) cube([0.4, 40, 30]);
    }
    hull() {
      translate([145.6, -20, 0]) cube([0.4, 40, 30]);
      translate([160, -13, 0]) cube([0.4, 26, 19.5]);
    }
    /* stiffening ribs across the flat top, sunk 0.8 mm into it */
    for (i = [1 : ribs]) {
      translate([14.4 + i * (length - 2 * 14.4) / (ribs + 1) - rib_t / 2, -width / 2, height - 0.8]) cube([rib_t, width, rib_h + 0.8]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -11.4, 4]) cube([0.4, 22.8, 13.9]);
    translate([9.4, -13.01, 4]) cube([0.4, 26.02, 16.73]);
  }
  hull() {
    translate([9.4, -13.01, 4]) cube([0.4, 26.02, 16.73]);
    translate([75, -16, 4]) cube([0.4, 32, 22]);
  }
  hull() {
    translate([75, -16, 4]) cube([0.4, 32, 22]);
    translate([140.6, -13.01, 4]) cube([0.4, 26.02, 16.73]);
  }
  hull() {
    translate([140.6, -13.01, 4]) cube([0.4, 26.02, 16.73]);
    translate([165, -11.4, 4]) cube([0.4, 22.8, 13.9]);
  }
}
