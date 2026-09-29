$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 28.3 / 25.3 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 28.3;           // outside diameter
inner_d = 25.3;           // shaft bore
length = 5;               // sleeve length
slot_w = 4;               // clamp slot width
slot_len = 3;             // clamp slot length

module sleeve() {
  cylinder(h = length, d = outer_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = length + 2, d = inner_d);
  translate([-outer_d / 2 - 1, -slot_w / 2, length / 2 - slot_len / 2]) cube([outer_d / 2 + 1, slot_w, slot_len]);
}
