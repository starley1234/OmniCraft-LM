$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA17, 55 x 51 x 13 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_x = 55;              // plate length, X
base_y = 51;              // plate width, Y
thick = 10;               // plate thickness
bolt_pitch = 31;          // NEMA17 bolt spacing
motor_d = 3.4;            // NEMA17 screw clearance
boss_hole = 22;           // pilot boss bore
boss_d = 30;              // raised pilot ring
boss_h = 3;               // raised pilot ring height
second_d = 4.5;           // second fastener hole

module plate() {
  translate([-base_x / 2, -base_y / 2, 0]) cube([base_x, base_y, thick]);
}

module motor_holes() {
  for (sx = [-1, 1]) for (sy = [-1, 1])
    translate([sx * bolt_pitch / 2, sy * bolt_pitch / 2, -1])
      cylinder(h = thick + 2, d = motor_d);
}
module pilot_ring() {
  translate([0, 0, thick - 1]) cylinder(h = boss_h + 1, d = boss_d);
}

difference() {
  union() {
    plate();
    pilot_ring();
  }
  motor_holes();
  translate([0, 0, -1]) cylinder(h = thick + boss_h + 2, d = boss_hole);
  for (sx = [-1, 1]) for (sy = [-1, 1])
    translate([sx * 20, sy * 19, -1]) cylinder(h = thick + 2, d = second_d);
}
