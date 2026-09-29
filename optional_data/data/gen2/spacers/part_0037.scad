$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 29.3 / 25.3 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tube_d = 29.3;            // outside diameter
bore_d = 25.3;            // shaft bore
tube_l = 6;               // sleeve length
step_d = 28.5;            // reduced diameter
step_l = 1.98;            // length of the step

module sleeve() {
  cylinder(h = tube_l, d = tube_d);
  translate([0, 0, tube_l - step_l]) cylinder(h = step_l, d = step_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = tube_l + 2, d = bore_d);
}
