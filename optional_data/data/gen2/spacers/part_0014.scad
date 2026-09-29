$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 13.5 / 8.5 x 20 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tube_d = 13.5;            // outside diameter
bore_d = 8.5;             // shaft bore
tube_l = 20;              // sleeve length
slot_w = 4;               // clamp slot width
slot_len = 12;            // clamp slot length

module sleeve() {
  cylinder(h = tube_l, d = tube_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = tube_l + 2, d = bore_d);
  translate([-tube_d / 2 - 1, -slot_w / 2, tube_l / 2 - slot_len / 2]) cube([tube_d / 2 + 1, slot_w, slot_len]);
}
