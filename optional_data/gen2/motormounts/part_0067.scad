$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA34, 89.6 x 99.6 x 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_w = 89.6;           // plate length, X
plate_d = 99.6;           // plate width, Y
plate_t = 12;             // plate thickness
pattern = 69.6;           // NEMA34 bolt spacing
motor_d = 6.6;            // NEMA34 screw clearance
pilot_d = 73.03;          // pilot boss bore
second_d = 6.6;           // second fastener hole

module plate() {
  translate([-plate_w / 2, -plate_d / 2, 0]) cube([plate_w, plate_d, plate_t]);
}

module motor_holes() {
  for (sx = [-1, 1]) for (sy = [-1, 1])
    translate([sx * pattern / 2, sy * pattern / 2, -1])
      cylinder(h = plate_t + 2, d = motor_d);
}

difference() {
  union() {
    plate();
  }
  motor_holes();
  translate([0, 0, -1]) cylinder(h = plate_t + 2, d = pilot_d);
  for (sx = [-1, 1]) for (sy = [-1, 1])
    translate([sx * 38.3, sy * 40.8, -1]) cylinder(h = plate_t + 2, d = second_d);
}
