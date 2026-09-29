$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA23, 61.14 x 67.14 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_x = 61.14;           // plate length, X
base_y = 67.14;           // plate width, Y
thick = 6;                // plate thickness
bolt_pitch = 47.14;       // NEMA23 bolt spacing
motor_d = 5.5;            // NEMA23 screw clearance
boss_hole = 38.1;         // pilot boss bore
second_d = 3.4;           // second fastener hole

module plate() {
  translate([-base_x / 2, -base_y / 2, 0]) cube([base_x, base_y, thick]);
}

module motor_holes() {
  for (sx = [-1, 1]) for (sy = [-1, 1])
    translate([sx * bolt_pitch / 2, sy * bolt_pitch / 2, -1])
      cylinder(h = thick + 2, d = motor_d);
}

difference() {
  union() {
    plate();
  }
  motor_holes();
  translate([0, 0, -1]) cylinder(h = thick + 2, d = boss_hole);
  for (sx = [-1, 1]) for (sy = [-1, 1])
    translate([sx * 25.57, sy * 27.07, -1]) cylinder(h = thick + 2, d = second_d);
}
