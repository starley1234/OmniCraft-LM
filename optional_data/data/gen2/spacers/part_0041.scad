$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 20.2 / 15.2 x 20 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sleeve_od = 20.2;         // outside diameter
sleeve_id = 15.2;         // shaft bore
sleeve_l = 20;            // sleeve length
flange_d = 24.2;          // collar diameter
flange_t = 2;             // collar thickness

module sleeve() {
  cylinder(h = sleeve_l, d = sleeve_od);
  cylinder(h = flange_t + 0.6, d = flange_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = sleeve_l + 2, d = sleeve_id);
}
