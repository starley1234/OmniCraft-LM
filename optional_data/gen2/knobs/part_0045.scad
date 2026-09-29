$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 30 x 49.2 x 33.75 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
head_d = 30;              // knob diameter
head_h = 25;              // knob height
hole_d = 6.35;            // shaft bore
set_d = 3.4;              // set screw tap hole
wing_l = 49.2;            // wing span
wing_w = 9;               // wing width
wing_h = 15;              // wing thickness
cap_h = 8.75;             // raised centre cap
cap_d = 15;               // centre cap diameter

module body() {
  cylinder(h = head_h, d = head_d);
}

module wing() {
  /* wing sunk 2 mm into the knob so the joint overlaps */
  translate([-wing_l / 2, -wing_w / 2, head_h - 2])
    cube([wing_l, wing_w, wing_h + 2]);
}

module cap() {
  translate([0, 0, head_h - 1]) cylinder(h = cap_h + 1, d = cap_d);
}

difference() {
  union() {
    body();
    wing();
    cap();
  }
  translate([0, 0, -1]) cylinder(h = head_h + cap_h + 2, d = hole_d);
  translate([-head_d / 2 - 1, 0, head_h * 0.5]) rotate([0, 90, 0]) cylinder(h = head_d / 2 + 2, d = set_d);
}
