$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 15.5 / 10.5 x 20 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sleeve_od = 15.5;         // outside diameter
sleeve_id = 10.5;         // shaft bore
sleeve_l = 20;            // sleeve length
step_d = 14.2;            // reduced diameter
step_l = 7.8;             // length of the step

module sleeve() {
  cylinder(h = sleeve_l, d = sleeve_od);
  translate([0, 0, sleeve_l - step_l]) cylinder(h = step_l, d = step_d);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = sleeve_l + 2, d = sleeve_id);
}
