$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 30 x 30 x 18 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
head_d = 30;              // knob diameter
head_h = 18;              // knob height
hole_d = 5;               // shaft bore
set_d = 3.4;              // set screw tap hole
notch_d = 1.24;           // knurl groove diameter
lobes = 5;                // grip lobes

module body() {
  cylinder(h = head_h, d = head_d);
  for (i = [0 : lobes - 1])
    rotate([0, 0, i * 360 / lobes])
      translate([head_d * 0.42, 0, 0])
        cylinder(h = head_h, d = head_d * 0.3);
}

difference() {
  union() {
    body();
  }
  translate([0, 0, -1]) cylinder(h = head_h + 0 + 2, d = hole_d);
  translate([-head_d / 2 - 1, 0, head_h * 0.5]) rotate([0, 90, 0]) cylinder(h = head_d / 2 + 2, d = set_d);
}
