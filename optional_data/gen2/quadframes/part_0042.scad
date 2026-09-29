$fn = 32;

// ----------------------------------------------------------------------
// Quadcopter frame: 248 mm across the motor pads, arms 106.56 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hub = 40;                 // central plate size
plate_t = 6;              // plate thickness
arm_len = 106.56;         // hub centre to motor pad centre
bar_w = 14;               // arm width
pad_d = 34.87;            // motor pad diameter
hole_x = 19;              // motor bolt spacing, X
hole_y = 19;              // motor bolt spacing, Y
hole_d = 3.4;             // motor bolt clearance
centre_d = 18;            // central cut-out for the stack

module arm_bar() {
  /* flat bar: hull of a stub inside the hub and a box at the pad */
  hull() {
    translate([hub / 4, 0, plate_t / 2]) cube([bar_w, bar_w, plate_t], center = true);
    translate([arm_len, 0, plate_t / 2]) cube([bar_w, bar_w, plate_t], center = true);
  }
}

module pad() {
  translate([arm_len, 0, 0]) cylinder(h = plate_t, d = pad_d);
}

module frame() {
  translate([-hub / 2, -hub / 2, 0]) cube([hub, hub, plate_t]);
  rotate([0, 0, 0]) arm_bar();
  rotate([0, 0, 0]) pad();
  rotate([0, 0, 90]) arm_bar();
  rotate([0, 0, 90]) pad();
  rotate([0, 0, 180]) arm_bar();
  rotate([0, 0, 180]) pad();
  rotate([0, 0, 270]) arm_bar();
  rotate([0, 0, 270]) pad();
}

difference() {
  frame();
  for (a = [0 : 3]) rotate([0, 0, a * 90 + 0])
    for (sx = [-1, 1]) for (sy = [-1, 1])
      translate([arm_len + sx * hole_x / 2, sy * hole_y / 2, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([0, 0, -1]) cylinder(h = plate_t + 2, d = centre_d);
}
