$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 23.5 / 15.5 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tube_d = 23.5;            // outside diameter
bore_d = 15.5;            // shaft bore
tube_l = 10;              // sleeve length

module sleeve() {
  cylinder(h = tube_l, d = tube_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = tube_l + 2, d = bore_d);
}
