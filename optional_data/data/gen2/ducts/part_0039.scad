$fn = 32;

// ----------------------------------------------------------------------
// Cable duct: 80 x 20 x 15 mm, 6 fingers
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tray_len = 80;            // duct length, X
tray_w = 20;              // duct width, Y
tray_h = 15;              // duct height, Z
tray_t = 2.5;             // side wall thickness
floor_t = 3;              // floor thickness
slot_w = 6;               // finger slot width
slot_h = 8.4;             // finger slot height
fingers = 6;              // number of finger slots per side
pitch = 13.33;            // finger pitch
hole_d = 3.4;             // floor mounting hole
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
