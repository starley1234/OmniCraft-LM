$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 24.3 / 20.3 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sleeve_od = 24.3;         // outside diameter
sleeve_id = 20.3;         // shaft bore
sleeve_l = 10;            // sleeve length
slot_w = 3;               // clamp slot width
slot_len = 6;             // clamp slot length

module sleeve() {
  cylinder(h = sleeve_l, d = sleeve_od);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = sleeve_l + 2, d = sleeve_id);
  translate([-sleeve_od / 2 - 1, -slot_w / 2, sleeve_l / 2 - slot_len / 2]) cube([sleeve_od / 2 + 1, slot_w, slot_len]);
}
