$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 20 x 20 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
grip_d = 20;              // knob diameter
grip_h = 25;              // knob height
shaft_d = 6;              // shaft bore
set_d = 3.4;              // set screw tap hole
knurl_dia = 0.97;         // knurl groove diameter
lobes = 6;                // grip lobes

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
