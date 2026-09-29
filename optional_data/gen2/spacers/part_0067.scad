$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 24.5 / 20.5 x 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 24.5;           // outside diameter
inner_d = 20.5;           // shaft bore
length = 12;              // sleeve length

module sleeve() {
  cylinder(h = length, d = outer_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = length + 2, d = inner_d);
}
