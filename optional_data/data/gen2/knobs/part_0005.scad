$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 30 x 30 x 24.3 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
knob_d = 30;              // knob diameter
knob_h = 18;              // knob height
bore_d = 9.6;             // shaft bore
set_d = 3.4;              // set screw tap hole
knurl_d = 0.51;           // knurl groove diameter
knurl_n = 30;             // number of knurl grooves
cap_h = 6.3;              // raised centre cap
cap_d = 15;               // centre cap diameter

module body() {
  cylinder(h = knob_h, d = knob_d);
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
  /* knurl grooves */
  for (i = [0 : knurl_n - 1])
    rotate([0, 0, i * 360 / knurl_n])
      translate([knob_d / 2, 0, -0.5])
        cylinder(h = knob_h + 1, d = knurl_d);
  translate([-knob_d / 2 - 1, 0, knob_h * 0.5]) rotate([0, 90, 0]) cylinder(h = knob_d / 2 + 2, d = set_d);
}
