$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 200 x 40 x 36 mm, 3 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 200;             // channel length
width = 40;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 3;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 26;               // faired end width
end_h = 23.4;             // faired end height
ribs = 3;                 // stiffening ribs on the top
rib_t = 2.4;              // rib thickness
rib_h = 3;                // rib height

difference() {
  union() {
    hull() {
      translate([0, -13, 0]) cube([0.4, 26, 23.4]);
      translate([18, -20, 0]) cube([0.4, 40, 36]);
    }
    hull() {
      translate([18, -20, 0]) cube([0.4, 40, 36]);
      translate([100, -20, 0]) cube([0.4, 40, 36]);
    }
    hull() {
      translate([100, -20, 0]) cube([0.4, 40, 36]);
      translate([182, -20, 0]) cube([0.4, 40, 36]);
    }
    hull() {
      translate([182, -20, 0]) cube([0.4, 40, 36]);
      translate([200, -13, 0]) cube([0.4, 26, 23.4]);
    }
    /* stiffening ribs across the flat top, sunk 0.8 mm into it */
    for (i = [1 : ribs]) {
      translate([18 + i * (length - 2 * 18) / (ribs + 1) - rib_t / 2, -width / 2, height - 0.8]) cube([rib_t, width, rib_h + 0.8]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -11.4, 4]) cube([0.4, 22.8, 17.8]);
    translate([13, -13.36, 4]) cube([0.4, 26.72, 21.72]);
  }
  hull() {
    translate([13, -13.36, 4]) cube([0.4, 26.72, 21.72]);
    translate([95, -17, 4]) cube([0.4, 34, 29]);
  }
  hull() {
    translate([95, -17, 4]) cube([0.4, 34, 29]);
    translate([177, -13.36, 4]) cube([0.4, 26.72, 21.72]);
  }
  hull() {
    translate([177, -13.36, 4]) cube([0.4, 26.72, 21.72]);
    translate([205, -11.4, 4]) cube([0.4, 22.8, 17.8]);
  }
}
