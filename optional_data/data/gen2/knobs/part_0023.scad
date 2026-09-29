$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 40 x 40 x 16.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
knob_d = 40;              // knob diameter
knob_h = 12;              // knob height
bore_d = 6.35;            // shaft bore
set_d = 3.4;              // set screw tap hole
knurl_d = 1.02;           // knurl groove diameter
knurl_n = 20;             // number of knurl grooves
cap_h = 4.2;              // raised centre cap
cap_d = 20;               // centre cap diameter

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
