$fn = 32;

// ----------------------------------------------------------------------
// Oldham coupling hub: 40 x 24 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
body_d = 40;              // hub diameter
body_l = 18;              // hub length
shaft_d = 6;              // shaft bore
cam_w = 12;               // drive tongue width
tongue_h = 6;             // drive tongue height
set_d = 3.4;              // set screw tap hole

module hub() {
  cylinder(h = body_l, d = body_d);
  /* tongue, clipped to the hub disc and sunk 1 mm into the face */
  intersection() {
    translate([-cam_w / 2, -body_d / 2, body_l - 1])
      cube([cam_w, body_d, tongue_h + 1]);
    translate([0, 0, body_l - 1]) cylinder(h = tongue_h + 1, d = body_d);
  }
}

difference() {
  hub();
  translate([0, 0, -1]) cylinder(h = body_l + tongue_h + 2, d = shaft_d);
  translate([-body_d / 2 - 1, 0, body_l * 0.5])
    rotate([0, 90, 0]) cylinder(h = body_d / 2 + 2, d = set_d);
}
