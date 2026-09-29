$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 21.5 / 15.5 x 20 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tube_d = 21.5;            // outside diameter
bore_d = 15.5;            // shaft bore
tube_l = 20;              // sleeve length
flange_d = 24.5;          // collar diameter
flange_t = 1.5;           // collar thickness

module sleeve() {
  cylinder(h = tube_l, d = tube_d);
  cylinder(h = flange_t + 0.6, d = flange_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = tube_l + 2, d = bore_d);
}
