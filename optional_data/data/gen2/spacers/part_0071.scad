$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 24.2 / 20.2 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 24.2;           // outside diameter
inner_d = 20.2;           // shaft bore
length = 8;               // sleeve length
slot_w = 3;               // clamp slot width
slot_len = 4.8;           // clamp slot length

module sleeve() {
  cylinder(h = length, d = outer_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = length + 2, d = inner_d);
  translate([-outer_d / 2 - 1, -slot_w / 2, length / 2 - slot_len / 2]) cube([outer_d / 2 + 1, slot_w, slot_len]);
}
