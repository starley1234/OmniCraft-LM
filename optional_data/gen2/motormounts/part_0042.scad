$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA23, 67.14 x 63.14 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
mount_w = 67.14;          // plate length, X
mount_d = 63.14;          // plate width, Y
mat_t = 10;               // plate thickness
motor_pitch = 47.14;      // NEMA23 bolt spacing
motor_d = 5.5;            // NEMA23 screw clearance
center_bore = 38.1;       // pilot boss bore
second_d = 4.5;           // second fastener hole

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
    translate([sx * 27.07, sy * 26.07, -1]) cylinder(h = mat_t + 2, d = second_d);
}
