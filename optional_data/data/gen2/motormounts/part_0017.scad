$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA17, 45 x 51 x 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_x = 45;              // plate length, X
base_y = 51;              // plate width, Y
thick = 12;               // plate thickness
bolt_pitch = 31;          // NEMA17 bolt spacing
motor_d = 3.4;            // NEMA17 screw clearance
boss_hole = 22;           // pilot boss bore

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
}
