$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA34, 99.6 x 93.6 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_x = 99.6;            // plate length, X
base_y = 93.6;            // plate width, Y
thick = 10;               // plate thickness
bolt_pitch = 69.6;        // NEMA34 bolt spacing
motor_d = 6.6;            // NEMA34 screw clearance
boss_hole = 73.03;        // pilot boss bore
second_d = 4.5;           // second fastener hole

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
    translate([sx * 40.8, sy * 39.3, -1]) cylinder(h = thick + 2, d = second_d);
}
