$fn = 32;

// ----------------------------------------------------------------------
// Enclosure body: 100 x 50 x 60 mm, wall 4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 100;             // outside length, X
width = 50;               // outside width, Y
height = 60;              // outside height, Z
wall = 4;                 // side wall thickness
floor_t = 5;              // floor thickness
boss_d = 12;              // corner boss diameter
boss_h = 53;              // corner boss height above the floor
boss_hole_d = 4.5;        // lid screw clearance in the boss
boss_lip = 9;             // boss centre inset from the corner
ear_w = 14;               // mounting ear width
ear_t = 4;                // mounting ear thickness
ear_ext = 8;              // mounting ear reach
ear_hole_d = 5.5;         // mounting ear drills
nipple_d = 20;            // cable gland boss diameter
nipple_h = 8;             // cable gland boss height
nipple_bore = 5;          // cable gland bore

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
    gland();
    ears();
  }
  /* boss screw holes */
  for (sx = [0, 1]) for (sy = [0, 1])
    translate([sx * (length - 2 * boss_lip) + boss_lip, sy * (width - 2 * boss_lip) + boss_lip, -1]) cylinder(h = floor_t + boss_h + 2, d = boss_hole_d);
  translate([length, width / 2, height * 0.5]) rotate([0, 90, 0]) translate([0, 0, -nipple_h - 2]) cylinder(h = nipple_h + wall + 4, d = nipple_bore);
  for (sz = [0, 1]) for (sx = [0, 1]) translate([-ear_ext - 1, width / 2 + (2 * sx - 1) * (ear_w / 2 - 3), sz * (height - ear_t) + ear_t / 2]) rotate([0, 90, 0]) cylinder(h = ear_ext + 2, d = ear_hole_d);
}
