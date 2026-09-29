$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 17.2 / 12.2 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 17.2;           // outside diameter
inner_d = 12.2;           // shaft bore
length = 25;              // sleeve length

module sleeve() {
  cylinder(h = length, d = outer_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = length + 2, d = inner_d);
}
