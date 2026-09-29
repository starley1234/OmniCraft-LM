$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 60 x 20 x 35 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
leg_a = 60;               // horizontal leg, X
leg_b = 35;               // vertical leg, Z
depth = 20;               // bracket depth, Y
thick = 3.5;              // plate thickness
hole_d = 9;               // clearance for M8

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = thick + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = thick + 5, d = hole_d);
}

difference() {
  union() {
    /* horizontal leg */
    cube([leg_a, depth, thick]);
    /* vertical leg, overlapping the corner block */
    cube([thick, depth, leg_b]);
  }
  hole_z(18, 10);
  hole_z(42, 10);
  hole_x(17.5, 10);
}
