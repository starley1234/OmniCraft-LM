$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA17, 55 x 61 x 9 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_x = 55;              // plate length, X
base_y = 61;              // plate width, Y
thick = 5;                // plate thickness
bolt_pitch = 31;          // NEMA17 bolt spacing
motor_d = 3.4;            // NEMA17 screw clearance
boss_hole = 22;           // pilot boss bore
cb_d = 7;                 // counterbore seat
cb_h = 1.87;              // counterbore depth
boss_d = 30;              // raised pilot ring
boss_h = 4;               // raised pilot ring height
second_d = 3.4;           // second fastener hole
bc_r = 17.6;              // second bolt circle radius
bc_n = 4;                 // second bolt circle count

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
  motor_counterbores();
  for (i = [0 : bc_n - 1]) rotate([0, 0, i * 360 / bc_n]) translate([bc_r, 0, -1])    cylinder(h = thick + 2, d = second_d);
}
