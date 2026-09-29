$fn = 32;

// ----------------------------------------------------------------------
// Quadcopter frame: 203.36 mm across the motor pads, arms 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hub = 80;                 // central plate size
plate_t = 6;              // plate thickness
arm_len = 80;             // hub centre to motor pad centre
bar_w = 14;               // arm width
pad_d = 43.36;            // motor pad diameter
hole_x = 25;              // motor bolt spacing, X
hole_y = 25;              // motor bolt spacing, Y
hole_d = 3.4;             // motor bolt clearance
centre_d = 34;            // central cut-out for the stack

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
  rotate([0, 0, 45]) arm_bar();
  rotate([0, 0, 45]) pad();
  rotate([0, 0, 135]) arm_bar();
  rotate([0, 0, 135]) pad();
  rotate([0, 0, 225]) arm_bar();
  rotate([0, 0, 225]) pad();
  rotate([0, 0, 315]) arm_bar();
  rotate([0, 0, 315]) pad();
}

difference() {
  frame();
  for (a = [0 : 3]) rotate([0, 0, a * 90 + 45])
    for (sx = [-1, 1]) for (sy = [-1, 1])
      translate([arm_len + sx * hole_x / 2, sy * hole_y / 2, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([0, 0, -1]) cylinder(h = plate_t + 2, d = centre_d);
}
