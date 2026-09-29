$fn = 32;

// ----------------------------------------------------------------------
// Spacer sleeve: 20.5 / 17.5 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sleeve_od = 20.5;         // outside diameter
sleeve_id = 17.5;         // shaft bore
sleeve_l = 25;            // sleeve length
slot_w = 4;               // clamp slot width
slot_len = 12;            // clamp slot length

module sleeve() {
  cylinder(h = sleeve_l, d = sleeve_od);
}

difference() {
  sleeve();
  translate([0, 0, -1]) cylinder(h = sleeve_l + 2, d = sleeve_id);
  translate([-sleeve_od / 2 - 1, -slot_w / 2, sleeve_l / 2 - slot_len / 2]) cube([sleeve_od / 2 + 1, slot_w, slot_len]);
}
