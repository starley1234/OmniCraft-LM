$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 13.2 / 10.2 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sleeve_od = 13.2;         // outside diameter
sleeve_id = 10.2;         // shaft bore
sleeve_l = 5;             // sleeve length

module sleeve() {
  cylinder(h = sleeve_l, d = sleeve_od);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = sleeve_l + 2, d = sleeve_id);
}
