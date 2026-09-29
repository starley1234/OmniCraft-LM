$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 30 x 16 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
arm_x = 30;               // horizontal leg, X
arm_z = 50;               // vertical leg, Z
width = 16;               // bracket depth, Y
wall = 3.5;               // plate thickness
hole_d = 9;               // clearance for M8

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = wall + 1, d = hole_d);
}
module hole_x(pz, py) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = wall + 1, d = hole_d);
}

difference() {
  union() {
    /* horizontal leg */
    cube([arm_x, width, wall]);
    /* vertical leg, overlapping the corner block */
    cube([wall, width, arm_z]);
  }
  hole_z(15, 8);
  hole_x(25, 8);
}
