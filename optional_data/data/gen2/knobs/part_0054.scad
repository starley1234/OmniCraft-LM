$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 50 x 88.5 x 20.25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
knob_d = 50;              // knob diameter
knob_h = 15;              // knob height
bore_d = 6.35;            // shaft bore
set_d = 3.4;              // set screw tap hole
wing_l = 88.5;            // wing span
wing_w = 15;              // wing width
wing_h = 9;               // wing thickness
cap_h = 5.25;             // raised centre cap
cap_d = 25;               // centre cap diameter

module body() {
  cylinder(h = knob_h, d = knob_d);
}

module wing() {
  /* wing sunk 2 mm into the knob so the joint overlaps */
  translate([-wing_l / 2, -wing_w / 2, knob_h - 2])
    cube([wing_l, wing_w, wing_h + 2]);
}

module cap() {
  translate([0, 0, knob_h - 1]) cylinder(h = cap_h + 1, d = cap_d);
}

difference() {
  union() {
    body();
    wing();
    cap();
  }
  translate([0, 0, -1]) cylinder(h = knob_h + cap_h + 2, d = bore_d);
  translate([-knob_d / 2 - 1, 0, knob_h * 0.5]) rotate([0, 90, 0]) cylinder(h = knob_d / 2 + 2, d = set_d);
}
