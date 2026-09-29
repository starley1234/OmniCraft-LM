$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 31.3 / 25.3 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 31.3;           // outside diameter
inner_d = 25.3;           // shaft bore
length = 25;              // sleeve length

module sleeve() {
  cylinder(h = length, d = outer_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = length + 2, d = inner_d);
}
