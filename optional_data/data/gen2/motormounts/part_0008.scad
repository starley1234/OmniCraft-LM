$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA23, 67.14 x 71.14 x 14 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
mount_w = 67.14;          // plate length, X
mount_d = 71.14;          // plate width, Y
mat_t = 12;               // plate thickness
motor_pitch = 47.14;      // NEMA23 bolt spacing
motor_d = 5.5;            // NEMA23 screw clearance
center_bore = 38.1;       // pilot boss bore
boss_d = 46.1;            // raised pilot ring
boss_h = 2;               // raised pilot ring height
second_d = 5.5;           // second fastener hole

module plate() {
  translate([-mount_w / 2, -mount_d / 2, 0]) cube([mount_w, mount_d, mat_t]);
}

module motor_holes() {
  for (sx = [-1, 1]) for (sy = [-1, 1])
    translate([sx * motor_pitch / 2, sy * motor_pitch / 2, -1])
      cylinder(h = mat_t + 2, d = motor_d);
}
module pilot_ring() {
  translate([0, 0, mat_t - 1]) cylinder(h = boss_h + 1, d = boss_d);
}

difference() {
  union() {
    plate();
    pilot_ring();
  }
  motor_holes();
  translate([0, 0, -1]) cylinder(h = mat_t + boss_h + 2, d = center_bore);
  for (sx = [-1, 1]) for (sy = [-1, 1])
    translate([sx * 27.07, sy * 28.07, -1]) cylinder(h = mat_t + 2, d = second_d);
}
