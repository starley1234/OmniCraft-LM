$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 12.2 / 8.2 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sleeve_od = 12.2;         // outside diameter
sleeve_id = 8.2;          // shaft bore
sleeve_l = 8;             // sleeve length
step_d = 11.4;            // reduced diameter
step_l = 2.8;             // length of the step

module sleeve() {
  cylinder(h = sleeve_l, d = sleeve_od);
  translate([0, 0, sleeve_l - step_l]) cylinder(h = step_l, d = step_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = sleeve_l + 2, d = sleeve_id);
}
