$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA17, 47 x 47 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
mount_w = 47;             // plate length, X
mount_d = 47;             // plate width, Y
mat_t = 10;               // plate thickness
motor_pitch = 31;         // NEMA17 bolt spacing
motor_d = 3.4;            // NEMA17 screw clearance
center_bore = 22;         // pilot boss bore

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
