$fn = 32;

// ----------------------------------------------------------------------
// Enclosure body: 60 x 60 x 80 mm, wall 2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 60;              // outside length, X
width = 60;               // outside width, Y
height = 80;              // outside height, Z
wall = 2;                 // side wall thickness
floor_t = 3;              // floor thickness
boss_d = 10;              // corner boss diameter
boss_h = 75;              // corner boss height above the floor
boss_hole_d = 3.4;        // lid screw clearance in the boss
boss_lip = 6;             // boss centre inset from the corner
ear_w = 14;               // mounting ear width
ear_t = 3;                // mounting ear thickness
ear_ext = 8;              // mounting ear reach
ear_hole_d = 3.4;         // mounting ear drills

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
