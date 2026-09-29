$fn = 32;

// ----------------------------------------------------------------------
// Enclosure body: 100 x 100 x 40 mm, wall 3 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 100;             // outside length, X
width = 100;              // outside width, Y
height = 40;              // outside height, Z
wall = 3;                 // side wall thickness
floor_t = 2.5;            // floor thickness
boss_d = 12;              // corner boss diameter
boss_h = 35.5;            // corner boss height above the floor
boss_hole_d = 4.5;        // lid screw clearance in the boss
boss_lip = 8;             // boss centre inset from the corner

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

difference() {
  union() {
    shell();
    bosses();
  }
  /* boss screw holes */
  for (sx = [0, 1]) for (sy = [0, 1])
    translate([sx * (length - 2 * boss_lip) + boss_lip, sy * (width - 2 * boss_lip) + boss_lip, -1]) cylinder(h = floor_t + boss_h + 2, d = boss_hole_d);
}
