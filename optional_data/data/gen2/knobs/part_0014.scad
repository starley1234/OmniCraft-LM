$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 40 x 40 x 27 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
head_d = 40;              // knob diameter
head_h = 20;              // knob height
hole_d = 10;              // shaft bore
set_d = 4.5;              // set screw tap hole
notch_d = 0.76;           // knurl groove diameter
knurl_n = 30;             // number of knurl grooves
cap_h = 7;                // raised centre cap
cap_d = 20;               // centre cap diameter

module body() {
  cylinder(h = head_h, d = head_d);
}

module cap() {
  translate([0, 0, head_h - 1]) cylinder(h = cap_h + 1, d = cap_d);
}

difference() {
  union() {
    body();
    cap();
  }
  translate([0, 0, -1]) cylinder(h = head_h + cap_h + 2, d = hole_d);
  /* knurl grooves */
  for (i = [0 : knurl_n - 1])
    rotate([0, 0, i * 360 / knurl_n])
      translate([head_d / 2, 0, -0.5])
        cylinder(h = head_h + 1, d = notch_d);
  translate([-head_d / 2 - 1, 0, head_h * 0.5]) rotate([0, 90, 0]) cylinder(h = head_d / 2 + 2, d = set_d);
}
