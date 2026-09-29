$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 26.2 / 20.2 x 15 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 26.2;           // outside diameter
inner_d = 20.2;           // shaft bore
length = 15;              // sleeve length

module sleeve() {
  cylinder(h = length, d = outer_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = length + 2, d = inner_d);
}
