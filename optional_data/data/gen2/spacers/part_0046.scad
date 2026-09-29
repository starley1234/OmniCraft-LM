$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 20.2 / 17.2 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tube_d = 20.2;            // outside diameter
bore_d = 17.2;            // shaft bore
tube_l = 6;               // sleeve length

module sleeve() {
  cylinder(h = tube_l, d = tube_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = tube_l + 2, d = bore_d);
}
