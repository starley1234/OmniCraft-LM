$fn = 32;

// ----------------------------------------------------------------------
// Cable duct: 100 x 50 x 40 mm, 12 fingers
// ----------------------------------------------------------------------

// --- parameters (mm) ---
channel_l = 100;          // duct length, X
channel_w = 50;           // duct width, Y
channel_h = 40;           // duct height, Z
channel_t = 3;            // side wall thickness
floor_t = 4;              // floor thickness
slot_w = 5;               // finger slot width
slot_h = 22;              // finger slot height
fingers = 12;             // number of finger slots per side
pitch = 8.33;             // finger pitch
ear_w = 11;               // mounting ear width
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
