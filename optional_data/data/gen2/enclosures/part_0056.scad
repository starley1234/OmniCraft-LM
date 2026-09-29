$fn = 32;

// ----------------------------------------------------------------------
// Enclosure body: 60 x 60 x 50 mm, wall 2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 60;              // outside length, X
width = 60;               // outside width, Y
height = 50;              // outside height, Z
wall = 2;                 // side wall thickness
floor_t = 2.5;            // floor thickness
boss_d = 8;               // corner boss diameter
boss_h = 45.5;            // corner boss height above the floor
boss_hole_d = 3.4;        // lid screw clearance in the boss
boss_lip = 5;             // boss centre inset from the corner
ear_w = 14;               // mounting ear width
ear_t = 3;                // mounting ear thickness
ear_ext = 8;              // mounting ear reach
ear_hole_d = 3.4;         // mounting ear drills
vent_slots = 10;          // vent slots in the long wall
vent_w = 3.6;             // vent slot width
vent_h = 16;              // vent slot height
vent_pitch = 5.45;        // vent slot pitch
vent_z = 25;              // vent slot sill height
nipple_d = 12;            // cable gland boss diameter
nipple_h = 8;             // cable gland boss height
nipple_bore = 8;          // cable gland bore

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
  /* vent grille in the +Y wall */
  for (i = [0 : vent_slots - 1]) translate([vent_pitch * (i + 1) - vent_w / 2, width - wall - 1, vent_z]) cube([vent_w, wall + 2, vent_h]);
  translate([length, width / 2, height * 0.5]) rotate([0, 90, 0]) translate([0, 0, -nipple_h - 2]) cylinder(h = nipple_h + wall + 4, d = nipple_bore);
  for (sz = [0, 1]) for (sx = [0, 1]) translate([-ear_ext - 1, width / 2 + (2 * sx - 1) * (ear_w / 2 - 3), sz * (height - ear_t) + ear_t / 2]) rotate([0, 90, 0]) cylinder(h = ear_ext + 2, d = ear_hole_d);
}
