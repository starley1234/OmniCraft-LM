$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 20 x 20 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
head_d = 20;              // knob diameter
head_h = 10;              // knob height
hole_d = 6.35;            // shaft bore
set_d = 3.4;              // set screw tap hole
notch_d = 0.43;           // knurl groove diameter
knurl_n = 24;             // number of knurl grooves

module body() {
  cylinder(h = head_h, d = head_d);
}

difference() {
  union() {
    body();
  }
  translate([0, 0, -1]) cylinder(h = head_h + 0 + 2, d = hole_d);
  /* knurl grooves */
  for (i = [0 : knurl_n - 1])
    rotate([0, 0, i * 360 / knurl_n])
      translate([head_d / 2, 0, -0.5])
        cylinder(h = head_h + 1, d = notch_d);
  translate([-head_d / 2 - 1, 0, head_h * 0.5]) rotate([0, 90, 0]) cylinder(h = head_d / 2 + 2, d = set_d);
}
