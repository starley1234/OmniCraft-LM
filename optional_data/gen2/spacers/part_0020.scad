$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 16.3 / 10.3 x 15 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sleeve_od = 16.3;         // outside diameter
sleeve_id = 10.3;         // shaft bore
sleeve_l = 15;            // sleeve length

module sleeve() {
  cylinder(h = sleeve_l, d = sleeve_od);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = sleeve_l + 2, d = sleeve_id);
}
