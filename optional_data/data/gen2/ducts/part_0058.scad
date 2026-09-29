$fn = 32;

// ----------------------------------------------------------------------
// Cable duct: 180 x 30 x 40 mm, 10 fingers
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tray_len = 180;           // duct length, X
tray_w = 30;              // duct width, Y
tray_h = 40;              // duct height, Z
tray_t = 2;               // side wall thickness
floor_t = 3;              // floor thickness
slot_w = 3;               // finger slot width
slot_h = 26;              // finger slot height
fingers = 10;             // number of finger slots per side
pitch = 18;               // finger pitch

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
