$fn = 32;

// ----------------------------------------------------------------------
// Enclosure box: bosses enclosure
// ----------------------------------------------------------------------

// --- parameters (mm) ---
box_l = 80;               // outer length, X
box_w = 50;               // outer width, Y
box_h = 40;               // outer height
wall_t = 2.5;             // wall thickness
boss_r = 5;               // corner boss radius
hole_r = 2;               // boss screw hole radius
boss_in = 12;             // boss inset from the corners

inner_h = box_h - wall_t;  // cavity depth
boss_h = inner_h - 2;  // corner boss height

difference() {
  cube([box_l, box_w, box_h]);
  translate([wall_t, wall_t, wall_t])
    cube([box_l - 2 * wall_t, box_w - 2 * wall_t, box_h]);
  for (sx = [0, 1], sy = [0, 1])
    translate([sx ? box_l - boss_in : boss_in,
               sy ? box_w - boss_in : boss_in, wall_t - 1]) {
      cylinder(r = boss_r, h = boss_h);
      translate([0, 0, boss_h - 4])
        cylinder(r = hole_r, h = 5);
    }
}
