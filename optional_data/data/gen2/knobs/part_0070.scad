$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 25 x 25 x 13.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
knob_d = 25;              // knob diameter
knob_h = 10;              // knob height
bore_d = 6.35;            // shaft bore
set_d = 3.4;              // set screw tap hole
knurl_d = 0.52;           // knurl groove diameter
lobes = 4;                // grip lobes
cap_h = 3.5;              // raised centre cap
cap_d = 12.5;             // centre cap diameter

module body() {
  cylinder(h = knob_h, d = knob_d);
  for (i = [0 : lobes - 1])
    rotate([0, 0, i * 360 / lobes])
      translate([knob_d * 0.42, 0, 0])
        cylinder(h = knob_h, d = knob_d * 0.3);
}

module cap() {
  translate([0, 0, knob_h - 1]) cylinder(h = cap_h + 1, d = cap_d);
}

difference() {
  union() {
    body();
    cap();
  }
  translate([0, 0, -1]) cylinder(h = knob_h + cap_h + 2, d = bore_d);
  translate([-knob_d / 2 - 1, 0, knob_h * 0.5]) rotate([0, 90, 0]) cylinder(h = knob_d / 2 + 2, d = set_d);
}
