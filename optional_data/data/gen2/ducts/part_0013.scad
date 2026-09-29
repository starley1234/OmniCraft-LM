$fn = 32;

// ----------------------------------------------------------------------
// Cable duct: 150 x 20 x 20 mm, 10 fingers
// ----------------------------------------------------------------------

// --- parameters (mm) ---
channel_l = 150;          // duct length, X
channel_w = 20;           // duct width, Y
channel_h = 20;           // duct height, Z
channel_t = 2.5;          // side wall thickness
floor_t = 3;              // floor thickness
slot_w = 5;               // finger slot width
slot_h = 12;              // finger slot height
fingers = 10;             // number of finger slots per side
pitch = 15;               // finger pitch

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
