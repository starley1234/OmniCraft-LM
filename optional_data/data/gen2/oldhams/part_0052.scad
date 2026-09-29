$fn = 32;

// ----------------------------------------------------------------------
// Oldham coupling hub: 28 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hub_d = 28;               // hub diameter
hub_l = 20;               // hub length
bore_d = 10;              // shaft bore
tongue_w = 16;            // drive tongue width
tongue_h = 5;             // drive tongue height
set_d = 4.5;              // set screw tap hole

module hub() {
  /* the slot side is a raised disc with a groove milled across it */
  cylinder(h = hub_l + tongue_h, d = hub_d);
}

difference() {
  hub();
  translate([0, 0, -1]) cylinder(h = hub_l + tongue_h + 2, d = bore_d);
  translate([-hub_d / 2 - 1, 0, hub_l * 0.5])
    rotate([0, 90, 0]) cylinder(h = hub_d / 2 + 2, d = set_d);
  translate([-tongue_w / 2, -hub_d / 2 - 1, hub_l - 1])
    cube([tongue_w, hub_d + 2, tongue_h + 1]);
}
