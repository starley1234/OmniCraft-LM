$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA17, 55 x 51 x 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_w = 55;             // plate length, X
plate_d = 51;             // plate width, Y
plate_t = 12;             // plate thickness
pattern = 31;             // NEMA17 bolt spacing
motor_d = 3.4;            // NEMA17 screw clearance
pilot_d = 22;             // pilot boss bore
cb_d = 7;                 // counterbore seat
cb_h = 1.87;              // counterbore depth

module plate() {
  translate([-plate_w / 2, -plate_d / 2, 0]) cube([plate_w, plate_d, plate_t]);
}

module motor_holes() {
  for (sx = [-1, 1]) for (sy = [-1, 1])
    translate([sx * pattern / 2, sy * pattern / 2, -1])
      cylinder(h = plate_t + 2, d = motor_d);
}
module motor_counterbores() {
  for (sx = [-1, 1]) for (sy = [-1, 1])
    translate([sx * pattern / 2, sy * pattern / 2, plate_t - cb_h])
      cylinder(h = cb_h + 0.6, d = cb_d);
}

difference() {
  union() {
    plate();
  }
  motor_holes();
  translate([0, 0, -1]) cylinder(h = plate_t + 2, d = pilot_d);
  motor_counterbores();
}
