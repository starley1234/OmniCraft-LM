$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 15.2 / 12.2 x 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sleeve_od = 15.2;         // outside diameter
sleeve_id = 12.2;         // shaft bore
sleeve_l = 12;            // sleeve length

module sleeve() {
  cylinder(h = sleeve_l, d = sleeve_od);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = sleeve_l + 2, d = sleeve_id);
}
