$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 24.5 / 20.5 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sleeve_od = 24.5;         // outside diameter
sleeve_id = 20.5;         // shaft bore
sleeve_l = 6;             // sleeve length

module sleeve() {
  cylinder(h = sleeve_l, d = sleeve_od);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = sleeve_l + 2, d = sleeve_id);
}
