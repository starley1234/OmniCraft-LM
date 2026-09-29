$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 18.5 / 10.5 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tube_d = 18.5;            // outside diameter
bore_d = 10.5;            // shaft bore
tube_l = 10;              // sleeve length
flange_d = 24.5;          // collar diameter
flange_t = 3;             // collar thickness

module sleeve() {
  cylinder(h = tube_l, d = tube_d);
  cylinder(h = flange_t + 0.6, d = flange_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = tube_l + 2, d = bore_d);
}
