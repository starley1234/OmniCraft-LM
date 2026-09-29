$fn = 32;

// ----------------------------------------------------------------------
// Enclosure body: 80 x 80 x 50 mm, wall 4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 80;              // outside length, X
width = 80;               // outside width, Y
height = 50;              // outside height, Z
wall = 4;                 // side wall thickness
floor_t = 3;              // floor thickness
boss_d = 8;               // corner boss diameter
boss_h = 45;              // corner boss height above the floor
boss_hole_d = 4.5;        // lid screw clearance in the boss
boss_lip = 7;             // boss centre inset from the corner
ear_w = 14;               // mounting ear width
ear_t = 4;                // mounting ear thickness
ear_ext = 8;              // mounting ear reach
ear_hole_d = 4.5;         // mounting ear drills

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

module ears() {
  /* mounting ears on the short walls, sunk into the wall */
  for (sz = [0, 1])
    translate([-ear_ext, width / 2 - ear_w / 2, sz * (height - ear_t)])
      cube([ear_ext + 2.5, ear_w, ear_t]);
}

difference() {
  union() {
    shell();
    bosses();
    ears();
  }
  /* boss screw holes */
  for (sx = [0, 1]) for (sy = [0, 1])
    translate([sx * (length - 2 * boss_lip) + boss_lip, sy * (width - 2 * boss_lip) + boss_lip, -1]) cylinder(h = floor_t + boss_h + 2, d = boss_hole_d);
  for (sz = [0, 1]) for (sx = [0, 1]) translate([-ear_ext - 1, width / 2 + (2 * sx - 1) * (ear_w / 2 - 3), sz * (height - ear_t) + ear_t / 2]) rotate([0, 90, 0]) cylinder(h = ear_ext + 2, d = ear_hole_d);
}
