$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 18.5 / 15.5 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 18.5;           // outside diameter
inner_d = 15.5;           // shaft bore
length = 6;               // sleeve length

module sleeve() {
  cylinder(h = length, d = outer_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = length + 2, d = inner_d);
}
