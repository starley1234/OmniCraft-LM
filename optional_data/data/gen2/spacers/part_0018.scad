$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 29.5 / 25.5 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tube_d = 29.5;            // outside diameter
bore_d = 25.5;            // shaft bore
tube_l = 6;               // sleeve length

module sleeve() {
  cylinder(h = tube_l, d = tube_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = tube_l + 2, d = bore_d);
}
