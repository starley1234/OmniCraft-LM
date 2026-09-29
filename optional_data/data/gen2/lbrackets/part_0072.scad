$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 40 x 16 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
arm_x = 40;               // horizontal leg, X
arm_z = 60;               // vertical leg, Z
width = 16;               // bracket depth, Y
wall = 3.5;               // plate thickness
hole_d = 3.4;             // clearance for M3

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
  hole_z(20, 8);
  hole_x(30, 8);
}
