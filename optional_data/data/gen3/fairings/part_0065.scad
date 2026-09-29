$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 160 x 58 x 42 mm, 3.5 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 160;             // channel length
width = 58;               // channel width at mid length
height = 42;              // channel height at mid length
wall = 3.5;               // side wall thickness
floor_t = 3;              // floor thickness
end_w = 40.6;             // faired end width
end_h = 29.4;             // faired end height
ribs = 3;                 // stiffening ribs on the top
rib_t = 3;                // rib thickness
rib_h = 4;                // rib height

difference() {
  union() {
    hull() {
      translate([0, -20.3, 0]) cube([0.4, 40.6, 29.4]);
      translate([14.4, -29, 0]) cube([0.4, 58, 42]);
    }
    hull() {
      translate([14.4, -29, 0]) cube([0.4, 58, 42]);
      translate([80, -29, 0]) cube([0.4, 58, 42]);
    }
    hull() {
      translate([80, -29, 0]) cube([0.4, 58, 42]);
      translate([145.6, -29, 0]) cube([0.4, 58, 42]);
    }
    hull() {
      translate([145.6, -29, 0]) cube([0.4, 58, 42]);
      translate([160, -20.3, 0]) cube([0.4, 40.6, 29.4]);
    }
    /* stiffening ribs across the flat top, sunk 0.8 mm into it */
    for (i = [1 : ribs]) {
      translate([14.4 + i * (length - 2 * 14.4) / (ribs + 1) - rib_t / 2, -width / 2, height - 0.8]) cube([rib_t, width, rib_h + 0.8]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -18.7, 3]) cube([0.4, 37.4, 24.8]);
    translate([9.4, -21.08, 3]) cube([0.4, 42.16, 28.55]);
  }
  hull() {
    translate([9.4, -21.08, 3]) cube([0.4, 42.16, 28.55]);
    translate([75, -25.5, 3]) cube([0.4, 51, 35.5]);
  }
  hull() {
    translate([75, -25.5, 3]) cube([0.4, 51, 35.5]);
    translate([140.6, -21.08, 3]) cube([0.4, 42.16, 28.55]);
  }
  hull() {
    translate([140.6, -21.08, 3]) cube([0.4, 42.16, 28.55]);
    translate([165, -18.7, 3]) cube([0.4, 37.4, 24.8]);
  }
}
