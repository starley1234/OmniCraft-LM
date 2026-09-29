$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 16.3 / 10.3 x 20 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tube_d = 16.3;            // outside diameter
bore_d = 10.3;            // shaft bore
tube_l = 20;              // sleeve length
flange_d = 20.3;          // collar diameter
flange_t = 2;             // collar thickness

module sleeve() {
  cylinder(h = tube_l, d = tube_d);
  cylinder(h = flange_t + 0.6, d = flange_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = tube_l + 2, d = bore_d);
}
