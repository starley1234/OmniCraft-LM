$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 18.2 / 15.2 x 12 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sleeve_od = 18.2;         // outside diameter
sleeve_id = 15.2;         // shaft bore
sleeve_l = 12;            // sleeve length

module sleeve() {
  cylinder(h = sleeve_l, d = sleeve_od);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = sleeve_l + 2, d = sleeve_id);
}
