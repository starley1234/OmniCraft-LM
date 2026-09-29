$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 35 x 35 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
grip_d = 35;              // knob diameter
grip_h = 10;              // knob height
shaft_d = 6.35;           // shaft bore
set_d = 3.4;              // set screw tap hole
knurl_dia = 0.77;         // knurl groove diameter
lobes = 4;                // grip lobes

module body() {
  cylinder(h = grip_h, d = grip_d);
  for (i = [0 : lobes - 1])
    rotate([0, 0, i * 360 / lobes])
      translate([grip_d * 0.42, 0, 0])
        cylinder(h = grip_h, d = grip_d * 0.3);
}

difference() {
  union() {
    body();
  }
  translate([0, 0, -1]) cylinder(h = grip_h + 0 + 2, d = shaft_d);
  translate([-grip_d / 2 - 1, 0, grip_h * 0.5]) rotate([0, 90, 0]) cylinder(h = grip_d / 2 + 2, d = set_d);
}
