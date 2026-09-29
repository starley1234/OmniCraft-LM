$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA34, 93.6 x 83.6 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
mount_w = 93.6;           // plate length, X
mount_d = 83.6;           // plate width, Y
mat_t = 6;                // plate thickness
motor_pitch = 69.6;       // NEMA34 bolt spacing
motor_d = 6.6;            // NEMA34 screw clearance
center_bore = 73.03;      // pilot boss bore
boss_d = 81;              // raised pilot ring
boss_h = 4;               // raised pilot ring height

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
}
