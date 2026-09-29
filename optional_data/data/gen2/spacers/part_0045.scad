$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 21.3 / 17.3 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sleeve_od = 21.3;         // outside diameter
sleeve_id = 17.3;         // shaft bore
sleeve_l = 5;             // sleeve length
step_d = 20.5;            // reduced diameter
step_l = 2.05;            // length of the step

module sleeve() {
  cylinder(h = sleeve_l, d = sleeve_od);
  translate([0, 0, sleeve_l - step_l]) cylinder(h = step_l, d = step_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = sleeve_l + 2, d = sleeve_id);
}
