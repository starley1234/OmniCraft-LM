$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 30.5 / 25.5 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sleeve_od = 30.5;         // outside diameter
sleeve_id = 25.5;         // shaft bore
sleeve_l = 6;             // sleeve length

module sleeve() {
  cylinder(h = sleeve_l, d = sleeve_od);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = sleeve_l + 2, d = sleeve_id);
}
