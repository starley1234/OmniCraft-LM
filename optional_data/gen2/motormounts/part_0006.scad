$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA34, 85.6 x 89.6 x 7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_w = 85.6;           // plate length, X
plate_d = 89.6;           // plate width, Y
plate_t = 5;              // plate thickness
pattern = 69.6;           // NEMA34 bolt spacing
motor_d = 6.6;            // NEMA34 screw clearance
pilot_d = 73.03;          // pilot boss bore
boss_d = 81;              // raised pilot ring
boss_h = 2;               // raised pilot ring height

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
}
