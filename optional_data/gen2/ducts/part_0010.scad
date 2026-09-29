$fn = 32;

// ----------------------------------------------------------------------
// Cable duct: 80 x 40 x 30 mm, 8 fingers
// ----------------------------------------------------------------------

// --- parameters (mm) ---
channel_l = 80;           // duct length, X
channel_w = 40;           // duct width, Y
channel_h = 30;           // duct height, Z
channel_t = 2.5;          // side wall thickness
floor_t = 3;              // floor thickness
slot_w = 6;               // finger slot width
slot_h = 18;              // finger slot height
fingers = 8;              // number of finger slots per side
pitch = 10;               // finger pitch
ear_w = 10.5;             // mounting ear width
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
