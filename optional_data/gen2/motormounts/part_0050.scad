$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA34, 99.6 x 83.6 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_w = 99.6;           // plate length, X
plate_d = 83.6;           // plate width, Y
plate_t = 8;              // plate thickness
pattern = 69.6;           // NEMA34 bolt spacing
motor_d = 6.6;            // NEMA34 screw clearance
pilot_d = 73.03;          // pilot boss bore
boss_d = 81;              // raised pilot ring
boss_h = 2;               // raised pilot ring height
second_d = 4.5;           // second fastener hole
bc_r = 26.8;              // second bolt circle radius
bc_n = 8;                 // second bolt circle count

module plate() {
  translate([-plate_w / 2, -plate_d / 2, 0]) cube([plate_w, plate_d, plate_t]);
}

module motor_holes() {
  for (sx = [-1, 1]) for (sy = [-1, 1])
    translate([sx * pattern / 2, sy * pattern / 2, -1])
      cylinder(h = plate_t + 2, d = motor_d);
}
module pilot_ring() {
  translate([0, 0, plate_t - 1]) cylinder(h = boss_h + 1, d = boss_d);
}

difference() {
  union() {
    plate();
    pilot_ring();
  }
  motor_holes();
  translate([0, 0, -1]) cylinder(h = plate_t + boss_h + 2, d = pilot_d);
  for (i = [0 : bc_n - 1]) rotate([0, 0, i * 360 / bc_n]) translate([bc_r, 0, -1])    cylinder(h = plate_t + 2, d = second_d);
}
