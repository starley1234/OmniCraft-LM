$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 28.5 / 25.5 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tube_d = 28.5;            // outside diameter
bore_d = 25.5;            // shaft bore
tube_l = 10;              // sleeve length
step_d = 28.2;            // reduced diameter
step_l = 4.2;             // length of the step

module sleeve() {
  cylinder(h = tube_l, d = tube_d);
  translate([0, 0, tube_l - step_l]) cylinder(h = step_l, d = step_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = tube_l + 2, d = bore_d);
}
