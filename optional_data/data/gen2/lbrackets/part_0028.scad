$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 70 x 16 x 30 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
arm_x = 70;               // horizontal leg, X
arm_z = 30;               // vertical leg, Z
width = 16;               // bracket depth, Y
wall = 6;                 // plate thickness
hole_d = 9;               // clearance for M8

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = wall + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = wall + 5, d = hole_d);
}

difference() {
  union() {
    /* horizontal leg */
    cube([arm_x, width, wall]);
    /* vertical leg, overlapping the corner block */
    cube([wall, width, arm_z]);
  }
  hole_z(18, 8);
  hole_z(52, 8);
  hole_x(15, 8);
}
