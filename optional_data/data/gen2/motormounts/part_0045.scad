$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA17, 61 x 51 x 55 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_x = 61;              // plate length, X
base_y = 51;              // plate width, Y
thick = 5;                // plate thickness
bolt_pitch = 31;          // NEMA17 bolt spacing
motor_d = 3.4;            // NEMA17 screw clearance
boss_hole = 22;           // pilot boss bore
cb_d = 7;                 // counterbore seat
cb_h = 1.87;              // counterbore depth
second_d = 3.4;           // second fastener hole
wall_h = 50;              // upright height
wall_t = 5;               // upright thickness

module plate() {
  translate([-base_x / 2, -base_y / 2, 0]) cube([base_x, base_y, thick]);
}

module motor_holes() {
  for (sx = [-1, 1]) for (sy = [-1, 1])
    translate([sx * bolt_pitch / 2, sy * bolt_pitch / 2, -1])
      cylinder(h = thick + 2, d = motor_d);
}
module motor_counterbores() {
  for (sx = [-1, 1]) for (sy = [-1, 1])
    translate([sx * bolt_pitch / 2, sy * bolt_pitch / 2, thick - cb_h])
      cylinder(h = cb_h + 0.6, d = cb_d);
}
module upright() {
  /* wall sunk 1 mm into the plate for a positive overlap */
  translate([base_x / 2 - wall_t, -base_y / 2 + wall_t, thick - 1])
    cube([wall_t, base_y - 2 * wall_t, wall_h - thick + 1]);
}

difference() {
  union() {
    plate();
    upright();
  }
  motor_holes();
  translate([0, 0, -1]) cylinder(h = thick + 2, d = boss_hole);
  motor_counterbores();
  for (i = [0 : 2])
    translate([base_x / 2 - wall_t - 1, (i - 1) * wall_h * 0.3, thick + wall_h * 0.45]) rotate([0, 90, 0]) cylinder(h = wall_t + 2, d = second_d);
}
