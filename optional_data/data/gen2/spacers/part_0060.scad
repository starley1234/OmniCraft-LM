$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 13.2 / 8.2 x 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 13.2;           // outside diameter
inner_d = 8.2;            // shaft bore
length = 12;              // sleeve length
flange_d = 17.2;          // collar diameter
flange_t = 1.5;           // collar thickness

module sleeve() {
  cylinder(h = length, d = outer_d);
  cylinder(h = flange_t + 0.6, d = flange_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = length + 2, d = inner_d);
}
