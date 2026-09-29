$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 20 x 35.2 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
knob_d = 20;              // knob diameter
knob_h = 10;              // knob height
bore_d = 6;               // shaft bore
set_d = 3.4;              // set screw tap hole
wing_l = 35.2;            // wing span
wing_w = 6;               // wing width
wing_h = 6;               // wing thickness

module body() {
  cylinder(h = knob_h, d = knob_d);
}

module wing() {
  /* wing sunk 2 mm into the knob so the joint overlaps */
  translate([-wing_l / 2, -wing_w / 2, knob_h - 2])
    cube([wing_l, wing_w, wing_h + 2]);
}

difference() {
  union() {
    body();
    wing();
  }
  translate([0, 0, -1]) cylinder(h = knob_h + 0 + 2, d = bore_d);
  translate([-knob_d / 2 - 1, 0, knob_h * 0.5]) rotate([0, 90, 0]) cylinder(h = knob_d / 2 + 2, d = set_d);
}
