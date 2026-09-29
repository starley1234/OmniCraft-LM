$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 11.3 / 8.3 x 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 11.3;           // outside diameter
inner_d = 8.3;            // shaft bore
length = 12;              // sleeve length

module sleeve() {
  cylinder(h = length, d = outer_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = length + 2, d = inner_d);
}
