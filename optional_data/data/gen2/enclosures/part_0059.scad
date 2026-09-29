$fn = 32;

// ----------------------------------------------------------------------
// Enclosure body: 100 x 40 x 30 mm, wall 3 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 100;             // outside length, X
width = 40;               // outside width, Y
height = 30;              // outside height, Z
wall = 3;                 // side wall thickness
floor_t = 5;              // floor thickness
boss_d = 8;               // corner boss diameter
boss_h = 23;              // corner boss height above the floor
boss_hole_d = 3.4;        // lid screw clearance in the boss
boss_lip = 6;             // boss centre inset from the corner
ear_w = 14;               // mounting ear width
ear_t = 3;                // mounting ear thickness
ear_ext = 8;              // mounting ear reach
ear_hole_d = 3.4;         // mounting ear drills
vent_slots = 5;           // vent slots in the long wall
vent_w = 2.4;             // vent slot width
vent_h = 20;              // vent slot height
vent_pitch = 6.67;        // vent slot pitch
vent_z = 15;              // vent slot sill height

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
  /* vent grille in the +Y wall */
  for (i = [0 : vent_slots - 1]) translate([vent_pitch * (i + 1) - vent_w / 2, width - wall - 1, vent_z]) cube([vent_w, wall + 2, vent_h]);
  for (sz = [0, 1]) for (sx = [0, 1]) translate([-ear_ext - 1, width / 2 + (2 * sx - 1) * (ear_w / 2 - 3), sz * (height - ear_t) + ear_t / 2]) rotate([0, 90, 0]) cylinder(h = ear_ext + 2, d = ear_hole_d);
}
