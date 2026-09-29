$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA17, 45 x 51 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
mount_w = 45;             // plate length, X
mount_d = 51;             // plate width, Y
mat_t = 5;                // plate thickness
motor_pitch = 31;         // NEMA17 bolt spacing
motor_d = 3.4;            // NEMA17 screw clearance
center_bore = 22;         // pilot boss bore
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
    translate([sx * 17.5, sy * 19, -1]) cylinder(h = mat_t + 2, d = second_d);
}
