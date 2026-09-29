$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 20 x 36.8 x 16.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
grip_d = 20;              // knob diameter
grip_h = 12;              // knob height
shaft_d = 6.4;            // shaft bore
set_d = 3.4;              // set screw tap hole
wing_l = 36.8;            // wing span
wing_w = 6;               // wing width
wing_h = 7.2;             // wing thickness
cap_h = 4.2;              // raised centre cap
cap_d = 10;               // centre cap diameter

module body() {
  cylinder(h = grip_h, d = grip_d);
}

module wing() {
  /* wing sunk 2 mm into the knob so the joint overlaps */
  translate([-wing_l / 2, -wing_w / 2, grip_h - 2])
    cube([wing_l, wing_w, wing_h + 2]);
}

module cap() {
  translate([0, 0, grip_h - 1]) cylinder(h = cap_h + 1, d = cap_d);
}

difference() {
  union() {
    body();
    wing();
    cap();
  }
  translate([0, 0, -1]) cylinder(h = grip_h + cap_h + 2, d = shaft_d);
  translate([-grip_d / 2 - 1, 0, grip_h * 0.5]) rotate([0, 90, 0]) cylinder(h = grip_d / 2 + 2, d = set_d);
}
