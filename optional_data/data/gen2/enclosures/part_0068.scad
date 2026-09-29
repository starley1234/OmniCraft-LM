$fn = 32;

// ----------------------------------------------------------------------
// Enclosure body: 100 x 80 x 30 mm, wall 2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 100;             // outside length, X
width = 80;               // outside width, Y
height = 30;              // outside height, Z
wall = 2;                 // side wall thickness
floor_t = 4;              // floor thickness
boss_d = 12;              // corner boss diameter
boss_h = 24;              // corner boss height above the floor
boss_hole_d = 3.4;        // lid screw clearance in the boss
boss_lip = 7;             // boss centre inset from the corner
vent_slots = 10;          // vent slots in the long wall
vent_w = 4;               // vent slot width
vent_h = 16;              // vent slot height
vent_pitch = 7.27;        // vent slot pitch
vent_z = 15;              // vent slot sill height
nipple_d = 12;            // cable gland boss diameter
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

difference() {
  union() {
    shell();
    bosses();
    gland();
  }
  /* boss screw holes */
  for (sx = [0, 1]) for (sy = [0, 1])
    translate([sx * (length - 2 * boss_lip) + boss_lip, sy * (width - 2 * boss_lip) + boss_lip, -1]) cylinder(h = floor_t + boss_h + 2, d = boss_hole_d);
  /* vent grille in the +Y wall */
  for (i = [0 : vent_slots - 1]) translate([vent_pitch * (i + 1) - vent_w / 2, width - wall - 1, vent_z]) cube([vent_w, wall + 2, vent_h]);
  translate([length, width / 2, height * 0.5]) rotate([0, 90, 0]) translate([0, 0, -nipple_h - 2]) cylinder(h = nipple_h + wall + 4, d = nipple_bore);
}
