$fn = 32;

// ----------------------------------------------------------------------
// Motor mount plate: NEMA17, 47 x 61 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_w = 47;             // plate length, X
plate_d = 61;             // plate width, Y
plate_t = 5;              // plate thickness
pattern = 31;             // NEMA17 bolt spacing
motor_d = 3.4;            // NEMA17 screw clearance
pilot_d = 22;             // pilot boss bore
cb_d = 7;                 // counterbore seat
cb_h = 1.87;              // counterbore depth
second_d = 4.5;           // second fastener hole
bc_r = 15;                // second bolt circle radius
bc_n = 8;                 // second bolt circle count

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
  for (i = [0 : bc_n - 1]) rotate([0, 0, i * 360 / bc_n]) translate([bc_r, 0, -1])    cylinder(h = plate_t + 2, d = second_d);
}
