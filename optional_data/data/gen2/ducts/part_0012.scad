$fn = 32;

// ----------------------------------------------------------------------
// Cable duct: 150 x 40 x 30 mm, 10 fingers
// ----------------------------------------------------------------------

// --- parameters (mm) ---
duct_len = 150;           // duct length, X
duct_w = 40;              // duct width, Y
duct_h = 30;              // duct height, Z
wall_t = 2;               // side wall thickness
floor_t = 2;              // floor thickness
slot_w = 4;               // finger slot width
slot_h = 19.8;            // finger slot height
fingers = 10;             // number of finger slots per side
pitch = 15;               // finger pitch
hole_d = 5.5;             // floor mounting hole
hole_n = 3;               // mounting holes in the floor
ear_w = 10;               // mounting ear width
ear_l = 14;               // mounting ear length

module shell() {
  difference() {
    cube([duct_len, duct_w, duct_h]);
    /* open top channel */
    translate([-wall_t - 1, wall_t, floor_t])
      cube([duct_len + 2 * wall_t + 2, duct_w - 2 * wall_t, duct_h + 1]);
  }
}

module ears() {
  translate([0, -ear_w + 1, 0]) cube([ear_l, ear_w, floor_t]);
  translate([0, duct_w - 1, 0]) cube([ear_l, ear_w, floor_t]);
}

difference() {
  union() {
    shell();
    ears();
  }
  /* finger slots cut through both side walls */
  for (i = [0 : fingers - 1]) translate([pitch / 2 + i * pitch - slot_w / 2, -1, floor_t + slot_h]) cube([slot_w, duct_w + 2, duct_h]);
  for (i = [0 : hole_n - 1]) translate([(duct_len / hole_n) * (i + 0.5), duct_w / 2, -1]) cylinder(h = floor_t + 2, d = hole_d);
}
