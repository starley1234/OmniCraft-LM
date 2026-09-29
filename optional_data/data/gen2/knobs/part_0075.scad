$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 25 x 25 x 15 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
knob_d = 25;              // knob diameter
knob_h = 15;              // knob height
bore_d = 8;               // shaft bore
set_d = 3.4;              // set screw tap hole
knurl_d = 0.71;           // knurl groove diameter
lobes = 4;                // grip lobes

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
