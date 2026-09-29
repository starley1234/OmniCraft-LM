$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 30.5 / 25.5 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 30.5;           // outside diameter
inner_d = 25.5;           // shaft bore
length = 10;              // sleeve length
slot_w = 3;               // clamp slot width
slot_len = 6;             // clamp slot length

module sleeve() {
  cylinder(h = length, d = outer_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = length + 2, d = inner_d);
  translate([-outer_d / 2 - 1, -slot_w / 2, length / 2 - slot_len / 2]) cube([outer_d / 2 + 1, slot_w, slot_len]);
}
