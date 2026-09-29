$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA23, 77.14 x 71.14 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_w = 77.14;          // plate length, X
plate_d = 71.14;          // plate width, Y
plate_t = 8;              // plate thickness
pattern = 47.14;          // NEMA23 bolt spacing
motor_d = 5.5;            // NEMA23 screw clearance
pilot_d = 38.1;           // pilot boss bore

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
}
