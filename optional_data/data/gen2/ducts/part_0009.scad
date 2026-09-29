$fn = 32;

// ----------------------------------------------------------------------
// Cable duct: 180 x 40 x 20 mm, 12 fingers
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tray_len = 180;           // duct length, X
tray_w = 40;              // duct width, Y
tray_h = 20;              // duct height, Z
tray_t = 4;               // side wall thickness
floor_t = 4;              // floor thickness
slot_w = 4;               // finger slot width
slot_h = 12;              // finger slot height
fingers = 12;             // number of finger slots per side
pitch = 15;               // finger pitch

module shell() {
  difference() {
    cube([tray_len, tray_w, tray_h]);
    /* open top channel */
    translate([-tray_t - 1, tray_t, floor_t])
      cube([tray_len + 2 * tray_t + 2, tray_w - 2 * tray_t, tray_h + 1]);
  }
}

difference() {
  union() {
    shell();
  }
  /* finger slots cut through both side walls */
  for (i = [0 : fingers - 1]) translate([pitch / 2 + i * pitch - slot_w / 2, -1, floor_t + slot_h]) cube([slot_w, tray_w + 2, tray_h]);
}
