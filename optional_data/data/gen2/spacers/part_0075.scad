$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 17.3 / 12.3 x 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tube_d = 17.3;            // outside diameter
bore_d = 12.3;            // shaft bore
tube_l = 12;              // sleeve length

module sleeve() {
  cylinder(h = tube_l, d = tube_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = tube_l + 2, d = bore_d);
}
