$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 17.5 / 12.5 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 17.5;           // outside diameter
inner_d = 12.5;           // shaft bore
length = 10;              // sleeve length

module sleeve() {
  cylinder(h = length, d = outer_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = length + 2, d = inner_d);
}
