$fn = 32;

// ----------------------------------------------------------------------
// Cable duct: 180 x 50 x 30 mm, 12 fingers
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_len = 180;           // duct length, X
duct_w = 50;              // duct width, Y
duct_h = 30;              // duct height, Z
wall_t = 3;               // side wall thickness
floor_t = 3;              // floor thickness
slot_w = 3;               // finger slot width
slot_h = 19.5;            // finger slot height
fingers = 12;             // number of finger slots per side
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
