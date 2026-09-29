$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 160 x 52 x 26 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 160;             // channel length
width = 52;               // channel width at mid length
height = 26;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 4;              // floor thickness
end_w = 31.2;             // faired end width
end_h = 15.6;             // faired end height
ribs = 4;                 // stiffening ribs on the top
rib_t = 3;                // rib thickness
rib_h = 4;                // rib height

difference() {
  union() {
    hull() {
      translate([0, -15.6, 0]) cube([0.4, 31.2, 15.6]);
      translate([14.4, -26, 0]) cube([0.4, 52, 26]);
    }
    hull() {
      translate([14.4, -26, 0]) cube([0.4, 52, 26]);
      translate([80, -26, 0]) cube([0.4, 52, 26]);
    }
    hull() {
      translate([80, -26, 0]) cube([0.4, 52, 26]);
      translate([145.6, -26, 0]) cube([0.4, 52, 26]);
    }
    hull() {
      translate([145.6, -26, 0]) cube([0.4, 52, 26]);
      translate([160, -15.6, 0]) cube([0.4, 31.2, 15.6]);
    }
    /* stiffening ribs across the flat top, sunk 0.8 mm into it */
    for (i = [1 : ribs]) {
      translate([14.4 + i * (length - 2 * 14.4) / (ribs + 1) - rib_t / 2, -width / 2, height - 0.8]) cube([rib_t, width, rib_h + 0.8]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -14, 4]) cube([0.4, 28, 10]);
    translate([9.4, -16.975, 4]) cube([0.4, 33.95, 12.97]);
  }
  hull() {
    translate([9.4, -16.975, 4]) cube([0.4, 33.95, 12.97]);
    translate([75, -22.5, 4]) cube([0.4, 45, 18.5]);
  }
  hull() {
    translate([75, -22.5, 4]) cube([0.4, 45, 18.5]);
    translate([140.6, -16.975, 4]) cube([0.4, 33.95, 12.97]);
  }
  hull() {
    translate([140.6, -16.975, 4]) cube([0.4, 33.95, 12.97]);
    translate([165, -14, 4]) cube([0.4, 28, 10]);
  }
}
