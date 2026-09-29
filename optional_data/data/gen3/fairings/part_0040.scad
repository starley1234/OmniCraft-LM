$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 46 x 36 mm, 4 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 46;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 4;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 29.9;             // faired end width
end_h = 23.4;             // faired end height
ribs = 4;                 // stiffening ribs on the top
rib_t = 2.4;              // rib thickness
rib_h = 4;                // rib height

difference() {
  union() {
    hull() {
      translate([0, -14.95, 0]) cube([0.4, 29.9, 23.4]);
      translate([18, -23, 0]) cube([0.4, 46, 36]);
    }
    hull() {
      translate([18, -23, 0]) cube([0.4, 46, 36]);
      translate([100, -23, 0]) cube([0.4, 46, 36]);
    }
    hull() {
      translate([100, -23, 0]) cube([0.4, 46, 36]);
      translate([182, -23, 0]) cube([0.4, 46, 36]);
    }
    hull() {
      translate([182, -23, 0]) cube([0.4, 46, 36]);
      translate([200, -14.95, 0]) cube([0.4, 29.9, 23.4]);
    }
    /* stiffening ribs across the flat top, sunk 0.8 mm into it */
    for (i = [1 : ribs]) {
      translate([18 + i * (length - 2 * 18) / (ribs + 1) - rib_t / 2, -width / 2, height - 0.8]) cube([rib_t, width, rib_h + 0.8]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -13.35, 4]) cube([0.4, 26.7, 17.8]);
    translate([13, -15.33, 4]) cube([0.4, 30.66, 21.37]);
  }
  hull() {
    translate([13, -15.33, 4]) cube([0.4, 30.66, 21.37]);
    translate([95, -19, 4]) cube([0.4, 38, 28]);
  }
  hull() {
    translate([95, -19, 4]) cube([0.4, 38, 28]);
    translate([177, -15.33, 4]) cube([0.4, 30.66, 21.37]);
  }
  hull() {
    translate([177, -15.33, 4]) cube([0.4, 30.66, 21.37]);
    translate([205, -13.35, 4]) cube([0.4, 26.7, 17.8]);
  }
}
