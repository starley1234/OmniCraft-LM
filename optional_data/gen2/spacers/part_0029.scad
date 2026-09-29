$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 30.3 / 25.3 x 20 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tube_d = 30.3;            // outside diameter
bore_d = 25.3;            // shaft bore
tube_l = 20;              // sleeve length

module sleeve() {
  cylinder(h = tube_l, d = tube_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = tube_l + 2, d = bore_d);
}
