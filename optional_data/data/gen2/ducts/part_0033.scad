$fn = 32;

// ----------------------------------------------------------------------
// Cable duct: 150 x 50 x 40 mm, 6 fingers
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tray_len = 150;           // duct length, X
tray_w = 50;              // duct width, Y
tray_h = 40;              // duct height, Z
tray_t = 4;               // side wall thickness
floor_t = 4;              // floor thickness
slot_w = 6;               // finger slot width
slot_h = 25.2;            // finger slot height
fingers = 6;              // number of finger slots per side
pitch = 25;               // finger pitch
ear_w = 12;               // mounting ear width
ear_l = 14;               // mounting ear length

module shell() {
  difference() {
    cube([tray_len, tray_w, tray_h]);
    /* open top channel */
    translate([-tray_t - 1, tray_t, floor_t])
      cube([tray_len + 2 * tray_t + 2, tray_w - 2 * tray_t, tray_h + 1]);
  }
}

module ears() {
  translate([0, -ear_w + 1, 0]) cube([ear_l, ear_w, floor_t]);
  translate([0, tray_w - 1, 0]) cube([ear_l, ear_w, floor_t]);
}

difference() {
  union() {
    shell();
    ears();
  }
  /* finger slots cut through both side walls */
  for (i = [0 : fingers - 1]) translate([pitch / 2 + i * pitch - slot_w / 2, -1, floor_t + slot_h]) cube([slot_w, tray_w + 2, tray_h]);
}
