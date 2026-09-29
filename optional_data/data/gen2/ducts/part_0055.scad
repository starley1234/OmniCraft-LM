$fn = 32;

// ----------------------------------------------------------------------
// Cable duct: 80 x 25 x 25 mm, 6 fingers
// ----------------------------------------------------------------------

// --- parameters (mm) ---
channel_l = 80;           // duct length, X
channel_w = 25;           // duct width, Y
channel_h = 25;           // duct height, Z
channel_t = 2;            // side wall thickness
floor_t = 4;              // floor thickness
slot_w = 4;               // finger slot width
slot_h = 16.5;            // finger slot height
fingers = 6;              // number of finger slots per side
pitch = 13.33;            // finger pitch
ear_w = 10;               // mounting ear width
ear_l = 14;               // mounting ear length

module shell() {
  difference() {
    cube([channel_l, channel_w, channel_h]);
    /* open top channel */
    translate([-channel_t - 1, channel_t, floor_t])
      cube([channel_l + 2 * channel_t + 2, channel_w - 2 * channel_t, channel_h + 1]);
  }
}

module ears() {
  translate([0, -ear_w + 1, 0]) cube([ear_l, ear_w, floor_t]);
  translate([0, channel_w - 1, 0]) cube([ear_l, ear_w, floor_t]);
}

difference() {
  union() {
    shell();
    ears();
  }
  /* finger slots cut through both side walls */
  for (i = [0 : fingers - 1]) translate([pitch / 2 + i * pitch - slot_w / 2, -1, floor_t + slot_h]) cube([slot_w, channel_w + 2, channel_h]);
}
