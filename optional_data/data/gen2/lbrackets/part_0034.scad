$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 30 x 20 x 70 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
arm_x = 30;               // horizontal leg, X
arm_z = 70;               // vertical leg, Z
width = 20;               // bracket depth, Y
wall = 4;                 // plate thickness
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
  hole_z(15, 10);
  hole_x(18, 10);
  hole_x(52, 10);
}
