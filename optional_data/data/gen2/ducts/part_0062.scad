$fn = 32;

// ----------------------------------------------------------------------
// Cable duct: 100 x 25 x 20 mm, 8 fingers
// ----------------------------------------------------------------------

// --- parameters (mm) ---
channel_l = 100;          // duct length, X
channel_w = 25;           // duct width, Y
channel_h = 20;           // duct height, Z
channel_t = 2;            // side wall thickness
floor_t = 4;              // floor thickness
slot_w = 4;               // finger slot width
slot_h = 11.8;            // finger slot height
fingers = 8;              // number of finger slots per side
pitch = 12.5;             // finger pitch
hole_d = 4.5;             // floor mounting hole
hole_n = 2;               // mounting holes in the floor

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
  for (i = [0 : hole_n - 1]) translate([(channel_l / hole_n) * (i + 0.5), channel_w / 2, -1]) cylinder(h = floor_t + 2, d = hole_d);
}
