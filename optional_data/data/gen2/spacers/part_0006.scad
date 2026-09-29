$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 21.5 / 15.5 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tube_d = 21.5;            // outside diameter
bore_d = 15.5;            // shaft bore
tube_l = 8;               // sleeve length
step_d = 20;              // reduced diameter
step_l = 3.04;            // length of the step

module sleeve() {
  cylinder(h = tube_l, d = tube_d);
  translate([0, 0, tube_l - step_l]) cylinder(h = step_l, d = step_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = tube_l + 2, d = bore_d);
}
