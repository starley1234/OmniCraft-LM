$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 20.3 / 15.3 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sleeve_od = 20.3;         // outside diameter
sleeve_id = 15.3;         // shaft bore
sleeve_l = 5;             // sleeve length

module sleeve() {
  cylinder(h = sleeve_l, d = sleeve_od);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = sleeve_l + 2, d = sleeve_id);
}
