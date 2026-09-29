$fn = 32;

// ----------------------------------------------------------------------
// Enclosure body: 60 x 60 x 25 mm, wall 2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 60;              // outside length, X
width = 60;               // outside width, Y
height = 25;              // outside height, Z
wall = 2;                 // side wall thickness
floor_t = 5;              // floor thickness
boss_d = 8;               // corner boss diameter
boss_h = 18;              // corner boss height above the floor
boss_hole_d = 3.4;        // lid screw clearance in the boss
boss_lip = 5;             // boss centre inset from the corner

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
