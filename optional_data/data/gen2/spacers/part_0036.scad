$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 28.5 / 20.5 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sleeve_od = 28.5;         // outside diameter
sleeve_id = 20.5;         // shaft bore
sleeve_l = 8;             // sleeve length

module sleeve() {
  cylinder(h = sleeve_l, d = sleeve_od);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = sleeve_l + 2, d = sleeve_id);
}
