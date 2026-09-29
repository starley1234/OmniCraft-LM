$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 29.2 / 25.2 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sleeve_od = 29.2;         // outside diameter
sleeve_id = 25.2;         // shaft bore
sleeve_l = 10;            // sleeve length

module sleeve() {
  cylinder(h = sleeve_l, d = sleeve_od);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = sleeve_l + 2, d = sleeve_id);
}
