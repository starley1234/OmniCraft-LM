$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 13.2 / 8.2 x 20 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 13.2;           // outside diameter
inner_d = 8.2;            // shaft bore
length = 20;              // sleeve length
step_d = 11.9;            // reduced diameter
step_l = 9;               // length of the step

module sleeve() {
  cylinder(h = length, d = outer_d);
  translate([0, 0, length - step_l]) cylinder(h = step_l, d = step_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = length + 2, d = inner_d);
}
