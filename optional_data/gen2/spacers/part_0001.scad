$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 15.5 / 12.5 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tube_d = 15.5;            // outside diameter
bore_d = 12.5;            // shaft bore
tube_l = 25;              // sleeve length
step_d = 15.2;            // reduced diameter
step_l = 9.25;            // length of the step

module sleeve() {
  cylinder(h = tube_l, d = tube_d);
  translate([0, 0, tube_l - step_l]) cylinder(h = step_l, d = step_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = tube_l + 2, d = bore_d);
}
