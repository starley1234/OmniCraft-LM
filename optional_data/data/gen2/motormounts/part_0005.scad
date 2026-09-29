$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA17, 47 x 47 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
mount_w = 47;             // plate length, X
mount_d = 47;             // plate width, Y
mat_t = 6;                // plate thickness
motor_pitch = 31;         // NEMA17 bolt spacing
motor_d = 3.4;            // NEMA17 screw clearance
center_bore = 22;         // pilot boss bore
cb_d = 7;                 // counterbore seat
cb_h = 1.87;              // counterbore depth
second_d = 5.5;           // second fastener hole
bc_r = 15;                // second bolt circle radius
bc_n = 8;                 // second bolt circle count

module plate() {
  translate([-mount_w / 2, -mount_d / 2, 0]) cube([mount_w, mount_d, mat_t]);
}

module motor_holes() {
  for (sx = [-1, 1]) for (sy = [-1, 1])
    translate([sx * motor_pitch / 2, sy * motor_pitch / 2, -1])
      cylinder(h = mat_t + 2, d = motor_d);
}
module motor_counterbores() {
  for (sx = [-1, 1]) for (sy = [-1, 1])
    translate([sx * motor_pitch / 2, sy * motor_pitch / 2, mat_t - cb_h])
      cylinder(h = cb_h + 0.6, d = cb_d);
}

difference() {
  union() {
    plate();
  }
  motor_holes();
  translate([0, 0, -1]) cylinder(h = mat_t + 2, d = center_bore);
  motor_counterbores();
  for (i = [0 : bc_n - 1]) rotate([0, 0, i * 360 / bc_n]) translate([bc_r, 0, -1])    cylinder(h = mat_t + 2, d = second_d);
}
