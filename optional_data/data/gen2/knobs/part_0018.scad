$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 25 x 45.5 x 16.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
head_d = 25;              // knob diameter
head_h = 12;              // knob height
hole_d = 8;               // shaft bore
set_d = 3.4;              // set screw tap hole
wing_l = 45.5;            // wing span
wing_w = 7.5;             // wing width
wing_h = 7.2;             // wing thickness
cap_h = 4.2;              // raised centre cap
cap_d = 12.5;             // centre cap diameter

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
