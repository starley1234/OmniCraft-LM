$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 50 x 50 x 18 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
knob_d = 50;              // knob diameter
knob_h = 18;              // knob height
bore_d = 12;              // shaft bore
set_d = 4.5;              // set screw tap hole
knurl_d = 1.19;           // knurl groove diameter
knurl_n = 24;             // number of knurl grooves

module body() {
  cylinder(h = knob_h, d = knob_d);
}

difference() {
  union() {
    body();
  }
  translate([0, 0, -1]) cylinder(h = knob_h + 0 + 2, d = bore_d);
  /* knurl grooves */
  for (i = [0 : knurl_n - 1])
    rotate([0, 0, i * 360 / knurl_n])
      translate([knob_d / 2, 0, -0.5])
        cylinder(h = knob_h + 1, d = knurl_d);
  translate([-knob_d / 2 - 1, 0, knob_h * 0.5]) rotate([0, 90, 0]) cylinder(h = knob_d / 2 + 2, d = set_d);
}
