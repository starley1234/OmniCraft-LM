$fn = 32;

// ----------------------------------------------------------------------
// Quadcopter frame: 152.84 mm across the motor pads, arms 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hub = 40;                 // central plate size
plate_t = 6;              // plate thickness
arm_len = 60;             // hub centre to motor pad centre
bar_w = 14;               // arm width
pad_d = 32.84;            // motor pad diameter
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
  translate([0, 0, -1]) cylinder(h = plate_t + 2, d = centre_d);
}
