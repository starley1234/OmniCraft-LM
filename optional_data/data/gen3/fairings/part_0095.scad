$fn = 32;

// ----------------------------------------------------------------------
// Faired channel: 180 x 46 x 36 mm, 4 mm walls, faired ends
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 180;             // channel length
width = 46;               // channel width at mid length
height = 36;              // channel height at mid length
wall = 4;                 // side wall thickness
floor_t = 3;              // floor thickness
end_w = 27.6;             // faired end width
end_h = 21.6;             // faired end height
ribs = 5;                 // stiffening ribs on the top
rib_t = 2.4;              // rib thickness
rib_h = 4;                // rib height

difference() {
  union() {
    hull() {
      translate([0, -13.8, 0]) cube([0.4, 27.6, 21.6]);
      translate([16.2, -23, 0]) cube([0.4, 46, 36]);
    }
    hull() {
      translate([16.2, -23, 0]) cube([0.4, 46, 36]);
      translate([90, -23, 0]) cube([0.4, 46, 36]);
    }
    hull() {
      translate([90, -23, 0]) cube([0.4, 46, 36]);
      translate([163.8, -23, 0]) cube([0.4, 46, 36]);
    }
    hull() {
      translate([163.8, -23, 0]) cube([0.4, 46, 36]);
      translate([180, -13.8, 0]) cube([0.4, 27.6, 21.6]);
    }
    /* stiffening ribs across the flat top, sunk 0.8 mm into it */
    for (i = [1 : ribs]) {
      translate([16.2 + i * (length - 2 * 16.2) / (ribs + 1) - rib_t / 2, -width / 2, height - 0.8]) cube([rib_t, width, rib_h + 0.8]);
    }
  }
  /* cavity, 5 mm proud of both ends so the ports are cut clean */
  hull() {
    translate([-5, -12.2, 3]) cube([0.4, 24.4, 17]);
    translate([11.2, -14.58, 3]) cube([0.4, 29.16, 21.2]);
  }
  hull() {
    translate([11.2, -14.58, 3]) cube([0.4, 29.16, 21.2]);
    translate([85, -19, 3]) cube([0.4, 38, 29]);
  }
  hull() {
    translate([85, -19, 3]) cube([0.4, 38, 29]);
    translate([158.8, -14.58, 3]) cube([0.4, 29.16, 21.2]);
  }
  hull() {
    translate([158.8, -14.58, 3]) cube([0.4, 29.16, 21.2]);
    translate([185, -12.2, 3]) cube([0.4, 24.4, 17]);
  }
}
