$fn = 32;

// ----------------------------------------------------------------------
// Oldham coupling hub: 32 x 24 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
body_d = 32;              // hub diameter
body_l = 20;              // hub length
shaft_d = 10;             // shaft bore
cam_w = 18;               // drive tongue width
tongue_h = 4;             // drive tongue height
set_d = 4.5;              // set screw tap hole

module hub() {
  /* the slot side is a raised disc with a groove milled across it */
  cylinder(h = body_l + tongue_h, d = body_d);
}

difference() {
  hub();
  translate([0, 0, -1]) cylinder(h = body_l + tongue_h + 2, d = shaft_d);
  translate([-body_d / 2 - 1, 0, body_l * 0.5])
    rotate([0, 90, 0]) cylinder(h = body_d / 2 + 2, d = set_d);
  translate([-cam_w / 2, -body_d / 2 - 1, body_l - 1])
    cube([cam_w, body_d + 2, tongue_h + 1]);
}
