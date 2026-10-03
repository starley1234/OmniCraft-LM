$fn = 32;
// ----------------------------------------------------------------------
// Hand knob: 35 x 58.1 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
grip_d = 35;              // knob diameter
grip_h = 25;              // knob height
shaft_d = 11.2;           // shaft bore
set_d = 4.5;              // set screw tap hole
wing_l = 58.1;            // wing span
wing_w = 10.5;            // wing width
wing_h = 15;              // wing thickness

module body() {
  cylinder(h = grip_h, d = grip_d);
}

module wing() {
  /* wing sunk 2 mm into the knob so the joint overlaps */
  translate([-wing_l / 2, -wing_w / 2, grip_h - 2])
    cube([wing_l, wing_w, wing_h + 2]);
}

difference() {
  union() {
    body();
    wing();
  }
  translate([0, 0, -1]) cylinder(h = grip_h + 0 + 2, d = shaft_d);
  translate([-grip_d / 2 - 1, 0, grip_h * 0.5]) rotate([0, 90, 0]) cylinder(h = grip_d / 2 + 2, d = set_d);
}
