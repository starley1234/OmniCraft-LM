$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 40 x 60 x 24.3 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
knob_d = 40;              // knob diameter
knob_h = 18;              // knob height
bore_d = 6;               // shaft bore
set_d = 3.4;              // set screw tap hole
wing_l = 60;              // wing span
wing_w = 12;              // wing width
wing_h = 10.8;            // wing thickness
cap_h = 6.3;              // raised centre cap
cap_d = 20;               // centre cap diameter

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
