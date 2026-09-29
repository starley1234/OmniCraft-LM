$fn = 32;

// ----------------------------------------------------------------------
// Oldham coupling hub: 32 x 22 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
flange_dia = 32;          // hub diameter
flange_len = 18;          // hub length
hub_bore = 8;             // shaft bore
key_w = 12;               // drive tongue width
tongue_h = 4;             // drive tongue height
set_d = 3.4;              // set screw tap hole

module hub() {
  cylinder(h = flange_len, d = flange_dia);
  /* tongue, clipped to the hub disc and sunk 1 mm into the face */
  intersection() {
    translate([-key_w / 2, -flange_dia / 2, flange_len - 1])
      cube([key_w, flange_dia, tongue_h + 1]);
    translate([0, 0, flange_len - 1]) cylinder(h = tongue_h + 1, d = flange_dia);
  }
}

difference() {
  hub();
  translate([0, 0, -1]) cylinder(h = flange_len + tongue_h + 2, d = hub_bore);
  translate([-flange_dia / 2 - 1, 0, flange_len * 0.5])
    rotate([0, 90, 0]) cylinder(h = flange_dia / 2 + 2, d = set_d);
}
