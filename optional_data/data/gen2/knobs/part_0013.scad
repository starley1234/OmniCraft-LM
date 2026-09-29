$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 20 x 20 x 33.75 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
grip_d = 20;              // knob diameter
grip_h = 25;              // knob height
shaft_d = 6.4;            // shaft bore
set_d = 3.4;              // set screw tap hole
knurl_dia = 0.43;         // knurl groove diameter
knurl_n = 30;             // number of knurl grooves
cap_h = 8.75;             // raised centre cap
cap_d = 10;               // centre cap diameter

module body() {
  cylinder(h = grip_h, d = grip_d);
}

module cap() {
  translate([0, 0, grip_h - 1]) cylinder(h = cap_h + 1, d = cap_d);
}

difference() {
  union() {
    body();
    cap();
  }
  translate([0, 0, -1]) cylinder(h = grip_h + cap_h + 2, d = shaft_d);
  /* knurl grooves */
  for (i = [0 : knurl_n - 1])
    rotate([0, 0, i * 360 / knurl_n])
      translate([grip_d / 2, 0, -0.5])
        cylinder(h = grip_h + 1, d = knurl_dia);
  translate([-grip_d / 2 - 1, 0, grip_h * 0.5]) rotate([0, 90, 0]) cylinder(h = grip_d / 2 + 2, d = set_d);
}
