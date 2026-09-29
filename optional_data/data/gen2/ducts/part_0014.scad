$fn = 32;

// ----------------------------------------------------------------------
// Cable duct: 120 x 50 x 40 mm, 8 fingers
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tray_len = 120;           // duct length, X
tray_w = 50;              // duct width, Y
tray_h = 40;              // duct height, Z
tray_t = 2;               // side wall thickness
floor_t = 2;              // floor thickness
slot_w = 5;               // finger slot width
slot_h = 20.8;            // finger slot height
fingers = 8;              // number of finger slots per side
pitch = 15;               // finger pitch
hole_d = 4.5;             // floor mounting hole
hole_n = 2;               // mounting holes in the floor

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
  for (i = [0 : hole_n - 1]) translate([(tray_len / hole_n) * (i + 0.5), tray_w / 2, -1]) cylinder(h = floor_t + 2, d = hole_d);
}
