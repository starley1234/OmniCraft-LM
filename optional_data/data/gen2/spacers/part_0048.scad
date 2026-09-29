$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 14.3 / 8.3 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tube_d = 14.3;            // outside diameter
bore_d = 8.3;             // shaft bore
tube_l = 5;               // sleeve length
step_d = 12.5;            // reduced diameter
step_l = 2.05;            // length of the step

module sleeve() {
  cylinder(h = tube_l, d = tube_d);
  translate([0, 0, tube_l - step_l]) cylinder(h = step_l, d = step_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = tube_l + 2, d = bore_d);
}
