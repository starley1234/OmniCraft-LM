$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA34, 93.6 x 85.6 x 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
mount_w = 93.6;           // plate length, X
mount_d = 85.6;           // plate width, Y
mat_t = 12;               // plate thickness
motor_pitch = 69.6;       // NEMA34 bolt spacing
motor_d = 6.6;            // NEMA34 screw clearance
center_bore = 73.03;      // pilot boss bore
second_d = 6.6;           // second fastener hole

module plate() {
  translate([-mount_w / 2, -mount_d / 2, 0]) cube([mount_w, mount_d, mat_t]);
}

module motor_holes() {
  for (sx = [-1, 1]) for (sy = [-1, 1])
    translate([sx * motor_pitch / 2, sy * motor_pitch / 2, -1])
      cylinder(h = mat_t + 2, d = motor_d);
}

difference() {
  union() {
    plate();
  }
  motor_holes();
  translate([0, 0, -1]) cylinder(h = mat_t + 2, d = center_bore);
  for (sx = [-1, 1]) for (sy = [-1, 1])
    translate([sx * 39.3, sy * 37.3, -1]) cylinder(h = mat_t + 2, d = second_d);
}
