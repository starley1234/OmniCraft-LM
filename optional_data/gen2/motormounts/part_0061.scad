$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA23, 77.14 x 77.14 x 13 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_x = 77.14;           // plate length, X
base_y = 77.14;           // plate width, Y
thick = 10;               // plate thickness
bolt_pitch = 47.14;       // NEMA23 bolt spacing
motor_d = 5.5;            // NEMA23 screw clearance
boss_hole = 38.1;         // pilot boss bore
boss_d = 46.1;            // raised pilot ring
boss_h = 3;               // raised pilot ring height

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
}
