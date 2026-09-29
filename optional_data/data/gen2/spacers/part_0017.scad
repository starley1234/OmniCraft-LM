$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 13.2 / 8.2 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tube_d = 13.2;            // outside diameter
bore_d = 8.2;             // shaft bore
tube_l = 10;              // sleeve length
slot_w = 4;               // clamp slot width
slot_len = 6;             // clamp slot length

module sleeve() {
  cylinder(h = tube_l, d = tube_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = tube_l + 2, d = bore_d);
  translate([-tube_d / 2 - 1, -slot_w / 2, tube_l / 2 - slot_len / 2]) cube([tube_d / 2 + 1, slot_w, slot_len]);
}
