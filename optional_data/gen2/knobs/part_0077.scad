$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 50 x 50 x 13.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
grip_d = 50;              // knob diameter
grip_h = 10;              // knob height
shaft_d = 8;              // shaft bore
set_d = 3.4;              // set screw tap hole
knurl_dia = 1.78;         // knurl groove diameter
lobes = 6;                // grip lobes
cap_h = 3.5;              // raised centre cap
cap_d = 25;               // centre cap diameter

module body() {
  cylinder(h = grip_h, d = grip_d);
  for (i = [0 : lobes - 1])
    rotate([0, 0, i * 360 / lobes])
      translate([grip_d * 0.42, 0, 0])
        cylinder(h = grip_h, d = grip_d * 0.3);
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
  translate([-grip_d / 2 - 1, 0, grip_h * 0.5]) rotate([0, 90, 0]) cylinder(h = grip_d / 2 + 2, d = set_d);
}
