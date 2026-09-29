$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 13.3 / 8.3 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sleeve_od = 13.3;         // outside diameter
sleeve_id = 8.3;          // shaft bore
sleeve_l = 5;             // sleeve length
flange_d = 16.3;          // collar diameter
flange_t = 1.5;           // collar thickness

module sleeve() {
  cylinder(h = sleeve_l, d = sleeve_od);
  cylinder(h = flange_t + 0.6, d = flange_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = sleeve_l + 2, d = sleeve_id);
}
