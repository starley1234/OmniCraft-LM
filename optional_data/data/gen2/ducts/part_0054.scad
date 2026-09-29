$fn = 32;

// ----------------------------------------------------------------------
// Cable duct: 150 x 30 x 20 mm, 10 fingers
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_len = 150;           // duct length, X
duct_w = 30;              // duct width, Y
duct_h = 20;              // duct height, Z
wall_t = 3;               // side wall thickness
floor_t = 4;              // floor thickness
slot_w = 6;               // finger slot width
slot_h = 14;              // finger slot height
fingers = 10;             // number of finger slots per side
pitch = 15;               // finger pitch

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
