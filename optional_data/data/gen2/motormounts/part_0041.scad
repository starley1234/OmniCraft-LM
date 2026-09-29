$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA23, 63.14 x 67.14 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
mount_w = 63.14;          // plate length, X
mount_d = 67.14;          // plate width, Y
mat_t = 5;                // plate thickness
motor_pitch = 47.14;      // NEMA23 bolt spacing
motor_d = 5.5;            // NEMA23 screw clearance
center_bore = 38.1;       // pilot boss bore

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
}
