$fn = 32;

// ----------------------------------------------------------------------
// Cable duct: 120 x 30 x 40 mm, 12 fingers
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_len = 120;           // duct length, X
duct_w = 30;              // duct width, Y
duct_h = 40;              // duct height, Z
wall_t = 2;               // side wall thickness
floor_t = 2;              // floor thickness
slot_w = 6;               // finger slot width
slot_h = 21.2;            // finger slot height
fingers = 12;             // number of finger slots per side
pitch = 10;               // finger pitch

module shell() {
  difference() {
    cube([duct_len, duct_w, duct_h]);
    /* open top channel */
    translate([-wall_t - 1, wall_t, floor_t])
      cube([duct_len + 2 * wall_t + 2, duct_w - 2 * wall_t, duct_h + 1]);
  }
}

difference() {
  union() {
    shell();
  }
  /* finger slots cut through both side walls */
  for (i = [0 : fingers - 1]) translate([pitch / 2 + i * pitch - slot_w / 2, -1, floor_t + slot_h]) cube([slot_w, duct_w + 2, duct_h]);
}
