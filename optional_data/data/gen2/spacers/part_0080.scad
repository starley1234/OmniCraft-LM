$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 26.5 / 20.5 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
outer_d = 26.5;           // outside diameter
inner_d = 20.5;           // shaft bore
length = 8;               // sleeve length
flange_d = 32.5;          // collar diameter
flange_t = 3;             // collar thickness

module sleeve() {
  cylinder(h = length, d = outer_d);
  cylinder(h = flange_t + 0.6, d = flange_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = length + 2, d = inner_d);
}
