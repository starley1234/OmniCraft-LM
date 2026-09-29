$fn = 32;

// ----------------------------------------------------------------------
// Cable duct: 100 x 30 x 20 mm, 12 fingers
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tray_len = 100;           // duct length, X
tray_w = 30;              // duct width, Y
tray_h = 20;              // duct height, Z
tray_t = 2.5;             // side wall thickness
floor_t = 2.5;            // floor thickness
slot_w = 4;               // finger slot width
slot_h = 13.6;            // finger slot height
fingers = 12;             // number of finger slots per side
pitch = 8.33;             // finger pitch
hole_d = 4.5;             // floor mounting hole
hole_n = 2;               // mounting holes in the floor
ear_w = 10.5;             // mounting ear width
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
  for (i = [0 : hole_n - 1]) translate([(tray_len / hole_n) * (i + 0.5), tray_w / 2, -1]) cylinder(h = floor_t + 2, d = hole_d);
}
