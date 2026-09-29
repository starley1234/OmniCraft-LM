$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 160 x 46 x 36 mm, 4 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 160;             // channel length
width = 46;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 4;                 // side wall thickness
floor_t = 4;              // floor thickness
end_w = 29.9;             // faired end width
end_h = 23.4;             // faired end height
ribs = 3;                 // stiffening ribs on the top
rib_t = 2.4;              // rib thickness
rib_h = 3;                // rib height

difference() {
  union() {
    hull() {
      translate([0, -14.95, 0]) cube([0.4, 29.9, 23.4]);
      translate([14.4, -23, 0]) cube([0.4, 46, 36]);
    }
    hull() {
      translate([14.4, -23, 0]) cube([0.4, 46, 36]);
      translate([80, -23, 0]) cube([0.4, 46, 36]);
    }
    hull() {
      translate([80, -23, 0]) cube([0.4, 46, 36]);
      translate([145.6, -23, 0]) cube([0.4, 46, 36]);
    }
    hull() {
      translate([145.6, -23, 0]) cube([0.4, 46, 36]);
      translate([160, -14.95, 0]) cube([0.4, 29.9, 23.4]);
    }
    /* stiffening ribs across the flat top, sunk 0.8 mm into it */
    for (i = [1 : ribs]) {
      translate([14.4 + i * (length - 2 * 14.4) / (ribs + 1) - rib_t / 2, -width / 2, height - 0.8]) cube([rib_t, width, rib_h + 0.8]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -13.35, 4]) cube([0.4, 26.7, 17.8]);
    translate([9.4, -15.33, 4]) cube([0.4, 30.66, 21.37]);
  }
  hull() {
    translate([9.4, -15.33, 4]) cube([0.4, 30.66, 21.37]);
    translate([75, -19, 4]) cube([0.4, 38, 28]);
  }
  hull() {
    translate([75, -19, 4]) cube([0.4, 38, 28]);
    translate([140.6, -15.33, 4]) cube([0.4, 30.66, 21.37]);
  }
  hull() {
    translate([140.6, -15.33, 4]) cube([0.4, 30.66, 21.37]);
    translate([165, -13.35, 4]) cube([0.4, 26.7, 17.8]);
  }
}
