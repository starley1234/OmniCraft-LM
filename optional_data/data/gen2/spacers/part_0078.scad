$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 18.5 / 10.5 x 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sleeve_od = 18.5;         // outside diameter
sleeve_id = 10.5;         // shaft bore
sleeve_l = 12;            // sleeve length
flange_d = 22.5;          // collar diameter
flange_t = 1.5;           // collar thickness

module sleeve() {
  cylinder(h = sleeve_l, d = sleeve_od);
  cylinder(h = flange_t + 0.6, d = flange_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = sleeve_l + 2, d = sleeve_id);
}
