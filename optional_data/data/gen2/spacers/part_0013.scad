$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 18.2 / 15.2 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
tube_d = 18.2;            // outside diameter
bore_d = 15.2;            // shaft bore
tube_l = 10;              // sleeve length
step_d = 17.9;            // reduced diameter
step_l = 4.4;             // length of the step

module sleeve() {
  cylinder(h = tube_l, d = tube_d);
  translate([0, 0, tube_l - step_l]) cylinder(h = step_l, d = step_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = tube_l + 2, d = bore_d);
}
