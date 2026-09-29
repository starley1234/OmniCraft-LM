$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 35 x 64.4 x 20 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
head_d = 35;              // knob diameter
head_h = 20;              // knob height
hole_d = 8;               // shaft bore
set_d = 3.4;              // set screw tap hole
wing_l = 64.4;            // wing span
wing_w = 10.5;            // wing width
wing_h = 12;              // wing thickness

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
