$fn = 32;

// ----------------------------------------------------------------------
// Oldham coupling hub: 28 x 23 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hub_d = 28;               // hub diameter
hub_l = 18;               // hub length
bore_d = 10;              // shaft bore
tongue_w = 14;            // drive tongue width
tongue_h = 5;             // drive tongue height
set_d = 4.5;              // set screw tap hole

module hub() {
  cylinder(h = hub_l, d = hub_d);
  /* tongue, clipped to the hub disc and sunk 1 mm into the face */
  intersection() {
    translate([-tongue_w / 2, -hub_d / 2, hub_l - 1])
      cube([tongue_w, hub_d, tongue_h + 1]);
    translate([0, 0, hub_l - 1]) cylinder(h = tongue_h + 1, d = hub_d);
  }
}

difference() {
  hub();
  translate([0, 0, -1]) cylinder(h = hub_l + tongue_h + 2, d = bore_d);
  translate([-hub_d / 2 - 1, 0, hub_l * 0.5])
    rotate([0, 90, 0]) cylinder(h = hub_d / 2 + 2, d = set_d);
}
