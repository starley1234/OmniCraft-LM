$fn = 32;

// ----------------------------------------------------------------------
// Cable duct: 80 x 30 x 40 mm, 6 fingers
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_len = 80;            // duct length, X
duct_w = 30;              // duct width, Y
duct_h = 40;              // duct height, Z
wall_t = 2;               // side wall thickness
floor_t = 3;              // floor thickness
slot_w = 4;               // finger slot width
slot_h = 22.8;            // finger slot height
fingers = 6;              // number of finger slots per side
pitch = 13.33;            // finger pitch
ear_w = 10;               // mounting ear width
ear_l = 14;               // mounting ear length

module shell() {
  difference() {
    cube([duct_len, duct_w, duct_h]);
    /* open top channel */
    translate([-wall_t - 1, wall_t, floor_t])
      cube([duct_len + 2 * wall_t + 2, duct_w - 2 * wall_t, duct_h + 1]);
  }
}

module ears() {
  translate([0, -ear_w + 1, 0]) cube([ear_l, ear_w, floor_t]);
  translate([0, duct_w - 1, 0]) cube([ear_l, ear_w, floor_t]);
}

difference() {
  union() {
    shell();
    ears();
  }
  /* finger slots cut through both side walls */
  for (i = [0 : fingers - 1]) translate([pitch / 2 + i * pitch - slot_w / 2, -1, floor_t + slot_h]) cube([slot_w, duct_w + 2, duct_h]);
}
