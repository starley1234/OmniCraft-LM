$fn = 32;
// ----------------------------------------------------------------------
// Motor mount plate: NEMA17, 61 x 45 x 13 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_w = 61;             // plate length, X
plate_d = 45;             // plate width, Y
plate_t = 10;             // plate thickness
pattern = 31;             // NEMA17 bolt spacing
motor_d = 3.4;            // NEMA17 screw clearance
pilot_d = 22;             // pilot boss bore
boss_d = 30;              // raised pilot ring
boss_h = 3;               // raised pilot ring height
second_d = 6.6;           // second fastener hole
bc_r = 14.4;              // second bolt circle radius
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
