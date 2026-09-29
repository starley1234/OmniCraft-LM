$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA17, 61 x 55 x 55 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_w = 61;             // plate length, X
plate_d = 55;             // plate width, Y
plate_t = 5;              // plate thickness
pattern = 31;             // NEMA17 bolt spacing
motor_d = 3.4;            // NEMA17 screw clearance
pilot_d = 22;             // pilot boss bore
second_d = 3.4;           // second fastener hole
wall_h = 50;              // upright height
wall_t = 6;               // upright thickness

module plate() {
  translate([-plate_w / 2, -plate_d / 2, 0]) cube([plate_w, plate_d, plate_t]);
}

module motor_holes() {
  for (sx = [-1, 1]) for (sy = [-1, 1])
    translate([sx * pattern / 2, sy * pattern / 2, -1])
      cylinder(h = plate_t + 2, d = motor_d);
}
module upright() {
  /* wall sunk 1 mm into the plate for a positive overlap */
  translate([plate_w / 2 - wall_t, -plate_d / 2 + wall_t, plate_t - 1])
    cube([wall_t, plate_d - 2 * wall_t, wall_h - plate_t + 1]);
}

difference() {
  union() {
    plate();
    upright();
  }
  motor_holes();
  translate([0, 0, -1]) cylinder(h = plate_t + 2, d = pilot_d);
  for (i = [0 : 2])
    translate([plate_w / 2 - wall_t - 1, (i - 1) * wall_h * 0.3, plate_t + wall_h * 0.45]) rotate([0, 90, 0]) cylinder(h = wall_t + 2, d = second_d);
}
