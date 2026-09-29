$fn = 32;

// ----------------------------------------------------------------------
// Cable duct: 60 x 30 x 20 mm, 6 fingers
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_len = 60;            // duct length, X
duct_w = 30;              // duct width, Y
duct_h = 20;              // duct height, Z
wall_t = 2.5;             // side wall thickness
floor_t = 2.5;            // floor thickness
slot_w = 3;               // finger slot width
slot_h = 13.6;            // finger slot height
fingers = 6;              // number of finger slots per side
pitch = 10;               // finger pitch
hole_d = 4.5;             // floor mounting hole
hole_n = 2;               // mounting holes in the floor

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
  for (i = [0 : hole_n - 1]) translate([(duct_len / hole_n) * (i + 0.5), duct_w / 2, -1]) cylinder(h = floor_t + 2, d = hole_d);
}
