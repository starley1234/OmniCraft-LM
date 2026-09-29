$fn = 32;

// ----------------------------------------------------------------------
// Oldham coupling hub: 28 x 26 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
flange_dia = 28;          // hub diameter
flange_len = 20;          // hub length
hub_bore = 10;            // shaft bore
key_w = 16;               // drive tongue width
tongue_h = 6;             // drive tongue height
set_d = 4.5;              // set screw tap hole

module hub() {
  /* the slot side is a raised disc with a groove milled across it */
  cylinder(h = flange_len + tongue_h, d = flange_dia);
}

difference() {
  hub();
  translate([0, 0, -1]) cylinder(h = flange_len + tongue_h + 2, d = hub_bore);
  translate([-flange_dia / 2 - 1, 0, flange_len * 0.5])
    rotate([0, 90, 0]) cylinder(h = flange_dia / 2 + 2, d = set_d);
  translate([-key_w / 2, -flange_dia / 2 - 1, flange_len - 1])
    cube([key_w, flange_dia + 2, tongue_h + 1]);
}
