$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA23, 67.14 x 63.14 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_x = 67.14;           // plate length, X
base_y = 63.14;           // plate width, Y
thick = 6;                // plate thickness
bolt_pitch = 47.14;       // NEMA23 bolt spacing
motor_d = 5.5;            // NEMA23 screw clearance
boss_hole = 38.1;         // pilot boss bore
second_d = 5.5;           // second fastener hole
bc_r = 20.2;              // second bolt circle radius
bc_n = 8;                 // second bolt circle count

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
  for (i = [0 : bc_n - 1]) rotate([0, 0, i * 360 / bc_n]) translate([bc_r, 0, -1])    cylinder(h = thick + 2, d = second_d);
}
