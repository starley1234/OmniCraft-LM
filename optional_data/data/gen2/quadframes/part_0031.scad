$fn = 32;

// ----------------------------------------------------------------------
// Quadcopter frame: 248 mm across the motor pads, arms 108 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hub = 80;                 // central plate size
plate_t = 6;              // plate thickness
arm_len = 108;            // hub centre to motor pad centre
bar_w = 10;               // arm width
pad_d = 32;               // motor pad diameter

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
}
