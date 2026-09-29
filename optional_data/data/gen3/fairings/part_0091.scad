$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 58 x 36 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 58;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 40.6;             // faired end width
end_h = 25.2;             // faired end height
ribs = 5;                 // stiffening ribs on the top
rib_t = 3;                // rib thickness
rib_h = 4;                // rib height

difference() {
  union() {
    hull() {
      translate([0, -20.3, 0]) cube([0.4, 40.6, 25.2]);
      translate([18, -29, 0]) cube([0.4, 58, 36]);
    }
    hull() {
      translate([18, -29, 0]) cube([0.4, 58, 36]);
      translate([100, -29, 0]) cube([0.4, 58, 36]);
    }
    hull() {
      translate([100, -29, 0]) cube([0.4, 58, 36]);
      translate([182, -29, 0]) cube([0.4, 58, 36]);
    }
    hull() {
      translate([182, -29, 0]) cube([0.4, 58, 36]);
      translate([200, -20.3, 0]) cube([0.4, 40.6, 25.2]);
    }
    /* stiffening ribs across the flat top, sunk 0.8 mm into it */
    for (i = [1 : ribs]) {
      translate([18 + i * (length - 2 * 18) / (ribs + 1) - rib_t / 2, -width / 2, height - 0.8]) cube([rib_t, width, rib_h + 0.8]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -18.7, 4]) cube([0.4, 37.4, 19.6]);
    translate([13, -21.255, 4]) cube([0.4, 42.51, 22.89]);
  }
  hull() {
    translate([13, -21.255, 4]) cube([0.4, 42.51, 22.89]);
    translate([95, -26, 4]) cube([0.4, 52, 29]);
  }
  hull() {
    translate([95, -26, 4]) cube([0.4, 52, 29]);
    translate([177, -21.255, 4]) cube([0.4, 42.51, 22.89]);
  }
  hull() {
    translate([177, -21.255, 4]) cube([0.4, 42.51, 22.89]);
    translate([205, -18.7, 4]) cube([0.4, 37.4, 19.6]);
  }
}
