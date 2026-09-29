$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 45 x 40 x 35 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
arm_x = 45;               // horizontal leg, X
arm_z = 35;               // vertical leg, Z
width = 40;               // bracket depth, Y
wall = 4;                 // plate thickness
hole_d = 3.4;             // clearance for M3

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
  hole_z(6.8, 20);
  hole_z(38.2, 20);
  hole_x(6.8, 20);
  hole_x(28.2, 20);
}
