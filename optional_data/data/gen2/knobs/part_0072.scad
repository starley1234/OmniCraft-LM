$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 35 x 35 x 18 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
knob_d = 35;              // knob diameter
knob_h = 18;              // knob height
bore_d = 6.35;            // shaft bore
set_d = 3.4;              // set screw tap hole
knurl_d = 1.01;           // knurl groove diameter
lobes = 6;                // grip lobes

module body() {
  cylinder(h = knob_h, d = knob_d);
  for (i = [0 : lobes - 1])
    rotate([0, 0, i * 360 / lobes])
      translate([knob_d * 0.42, 0, 0])
        cylinder(h = knob_h, d = knob_d * 0.3);
}

difference() {
  union() {
    body();
  }
  translate([0, 0, -1]) cylinder(h = knob_h + 0 + 2, d = bore_d);
  translate([-knob_d / 2 - 1, 0, knob_h * 0.5]) rotate([0, 90, 0]) cylinder(h = knob_d / 2 + 2, d = set_d);
}
