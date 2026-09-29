$fn = 32;

// ----------------------------------------------------------------------
// Hand knob: 50 x 90.5 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
head_d = 50;              // knob diameter
head_h = 10;              // knob height
hole_d = 10;              // shaft bore
set_d = 4.5;              // set screw tap hole
wing_l = 90.5;            // wing span
wing_w = 15;              // wing width
wing_h = 6;               // wing thickness

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
