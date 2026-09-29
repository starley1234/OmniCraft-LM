$fn = 32;

// ----------------------------------------------------------------------
// Enclosure body: 120 x 100 x 80 mm, wall 4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 120;             // outside length, X
width = 100;              // outside width, Y
height = 80;              // outside height, Z
wall = 4;                 // side wall thickness
floor_t = 4;              // floor thickness
boss_d = 10;              // corner boss diameter
boss_h = 74;              // corner boss height above the floor
boss_hole_d = 3.4;        // lid screw clearance in the boss
boss_lip = 8;             // boss centre inset from the corner
nipple_d = 20;            // cable gland boss diameter
nipple_h = 14;            // cable gland boss height
nipple_bore = 6.5;        // cable gland bore

module shell() {
  difference() {
    cube([length, width, height]);
    /* hollow, open at the top */
    translate([wall, wall, floor_t])
      cube([length - 2 * wall, width - 2 * wall, height]);
  }
}

module bosses() {
  /* corner bosses, sunk 1 mm into the floor */
  for (sx = [0, 1]) for (sy = [0, 1])
    translate([sx * (length - 2 * boss_lip) + boss_lip, sy * (width - 2 * boss_lip) + boss_lip, floor_t - 1])
      cylinder(h = boss_h + 1, d = boss_d);
}

module gland() {
  /* boss on the short wall, sunk 1 mm into it */
  translate([length - 1, width / 2, height * 0.5]) rotate([0, 90, 0])
    cylinder(h = nipple_h + 1, d = nipple_d);
}

difference() {
  union() {
    shell();
    bosses();
    gland();
  }
  /* boss screw holes */
  for (sx = [0, 1]) for (sy = [0, 1])
    translate([sx * (length - 2 * boss_lip) + boss_lip, sy * (width - 2 * boss_lip) + boss_lip, -1]) cylinder(h = floor_t + boss_h + 2, d = boss_hole_d);
  translate([length, width / 2, height * 0.5]) rotate([0, 90, 0]) translate([0, 0, -nipple_h - 2]) cylinder(h = nipple_h + wall + 4, d = nipple_bore);
}
