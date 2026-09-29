$fn = 32;

// ----------------------------------------------------------------------
// Cable duct: 120 x 20 x 25 mm, 6 fingers
// ----------------------------------------------------------------------

// --- parameters (mm) ---
channel_l = 120;          // duct length, X
channel_w = 20;           // duct width, Y
channel_h = 25;           // duct height, Z
channel_t = 3;            // side wall thickness
floor_t = 4;              // floor thickness
slot_w = 6;               // finger slot width
slot_h = 13.25;           // finger slot height
fingers = 6;              // number of finger slots per side
pitch = 20;               // finger pitch

module shell() {
  difference() {
    cube([channel_l, channel_w, channel_h]);
    /* open top channel */
    translate([-channel_t - 1, channel_t, floor_t])
      cube([channel_l + 2 * channel_t + 2, channel_w - 2 * channel_t, channel_h + 1]);
  }
}

difference() {
  union() {
    shell();
  }
  /* finger slots cut through both side walls */
  for (i = [0 : fingers - 1]) translate([pitch / 2 + i * pitch - slot_w / 2, -1, floor_t + slot_h]) cube([slot_w, channel_w + 2, channel_h]);
}
