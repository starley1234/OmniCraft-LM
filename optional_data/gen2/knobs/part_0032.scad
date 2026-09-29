$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 20 x 35 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
head_d = 20;              // knob diameter
head_h = 25;              // knob height
hole_d = 5;               // shaft bore
set_d = 3.4;              // set screw tap hole
wing_l = 35;              // wing span
wing_w = 6;               // wing width
wing_h = 15;              // wing thickness

module body() {
  cylinder(h = head_h, d = head_d);
}

module wing() {
  /* wing sunk 2 mm into the knob so the joint overlaps */
  translate([-wing_l / 2, -wing_w / 2, head_h - 2])
    cube([wing_l, wing_w, wing_h + 2]);
}

difference() {
  union() {
    body();
    wing();
  }
  translate([0, 0, -1]) cylinder(h = head_h + 0 + 2, d = hole_d);
  translate([-head_d / 2 - 1, 0, head_h * 0.5]) rotate([0, 90, 0]) cylinder(h = head_d / 2 + 2, d = set_d);
}
