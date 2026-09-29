$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 20.3 / 15.3 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tube_d = 20.3;            // outside diameter
bore_d = 15.3;            // shaft bore
tube_l = 8;               // sleeve length
slot_w = 3;               // clamp slot width
slot_len = 4.8;           // clamp slot length

module sleeve() {
  cylinder(h = tube_l, d = tube_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = tube_l + 2, d = bore_d);
  translate([-tube_d / 2 - 1, -slot_w / 2, tube_l / 2 - slot_len / 2]) cube([tube_d / 2 + 1, slot_w, slot_len]);
}
