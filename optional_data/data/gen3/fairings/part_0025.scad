$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 52 x 26 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 52;               // channel width at mid length
height = 26;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 3;              // floor thickness
end_w = 36.4;             // faired end width
end_h = 18.2;             // faired end height
ribs = 4;                 // stiffening ribs on the top
rib_t = 2.4;              // rib thickness
rib_h = 3;                // rib height

difference() {
  union() {
    hull() {
      translate([0, -18.2, 0]) cube([0.4, 36.4, 18.2]);
      translate([18, -26, 0]) cube([0.4, 52, 26]);
    }
    hull() {
      translate([18, -26, 0]) cube([0.4, 52, 26]);
      translate([100, -26, 0]) cube([0.4, 52, 26]);
    }
    hull() {
      translate([100, -26, 0]) cube([0.4, 52, 26]);
      translate([182, -26, 0]) cube([0.4, 52, 26]);
    }
    hull() {
      translate([182, -26, 0]) cube([0.4, 52, 26]);
      translate([200, -18.2, 0]) cube([0.4, 36.4, 18.2]);
    }
    /* stiffening ribs across the flat top, sunk 0.8 mm into it */
    for (i = [1 : ribs]) {
      translate([18 + i * (length - 2 * 18) / (ribs + 1) - rib_t / 2, -width / 2, height - 0.8]) cube([rib_t, width, rib_h + 0.8]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -16.6, 3]) cube([0.4, 33.2, 13.6]);
    translate([13, -18.665, 3]) cube([0.4, 37.33, 15.66]);
  }
  hull() {
    translate([13, -18.665, 3]) cube([0.4, 37.33, 15.66]);
    translate([95, -22.5, 3]) cube([0.4, 45, 19.5]);
  }
  hull() {
    translate([95, -22.5, 3]) cube([0.4, 45, 19.5]);
    translate([177, -18.665, 3]) cube([0.4, 37.33, 15.66]);
  }
  hull() {
    translate([177, -18.665, 3]) cube([0.4, 37.33, 15.66]);
    translate([205, -16.6, 3]) cube([0.4, 33.2, 13.6]);
  }
}
