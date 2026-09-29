$fn = 32;

// ----------------------------------------------------------------------
// Enclosure body: 100 x 40 x 80 mm, wall 3 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 100;             // outside length, X
width = 40;               // outside width, Y
height = 80;              // outside height, Z
wall = 3;                 // side wall thickness
floor_t = 4;              // floor thickness
boss_d = 10;              // corner boss diameter
boss_h = 74;              // corner boss height above the floor
boss_hole_d = 3.4;        // lid screw clearance in the boss
boss_lip = 7;             // boss centre inset from the corner
vent_slots = 8;           // vent slots in the long wall
vent_w = 2.4;             // vent slot width
vent_h = 12;              // vent slot height
vent_pitch = 4.44;        // vent slot pitch
vent_z = 40;              // vent slot sill height

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
  /* vent grille in the +Y wall */
  for (i = [0 : vent_slots - 1]) translate([vent_pitch * (i + 1) - vent_w / 2, width - wall - 1, vent_z]) cube([vent_w, wall + 2, vent_h]);
}
