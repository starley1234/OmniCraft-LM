$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 50 x 50 x 16.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
head_d = 50;              // knob diameter
head_h = 12;              // knob height
hole_d = 5;               // shaft bore
set_d = 3.4;              // set screw tap hole
notch_d = 1.02;           // knurl groove diameter
lobes = 5;                // grip lobes
cap_h = 4.2;              // raised centre cap
cap_d = 25;               // centre cap diameter

module body() {
  cylinder(h = head_h, d = head_d);
  for (i = [0 : lobes - 1])
    rotate([0, 0, i * 360 / lobes])
      translate([head_d * 0.42, 0, 0])
        cylinder(h = head_h, d = head_d * 0.3);
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
  translate([-head_d / 2 - 1, 0, head_h * 0.5]) rotate([0, 90, 0]) cylinder(h = head_d / 2 + 2, d = set_d);
}
