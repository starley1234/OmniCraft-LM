$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 20.5 / 15.5 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tube_d = 20.5;            // outside diameter
bore_d = 15.5;            // shaft bore
tube_l = 5;               // sleeve length
flange_d = 23.5;          // collar diameter
flange_t = 3;             // collar thickness

module sleeve() {
  cylinder(h = tube_l, d = tube_d);
  cylinder(h = flange_t + 0.6, d = flange_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = tube_l + 2, d = bore_d);
}
