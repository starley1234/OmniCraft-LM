$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 14.2 / 10.2 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 14.2;           // outside diameter
inner_d = 10.2;           // shaft bore
length = 25;              // sleeve length

module sleeve() {
  cylinder(h = length, d = outer_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = length + 2, d = inner_d);
}
