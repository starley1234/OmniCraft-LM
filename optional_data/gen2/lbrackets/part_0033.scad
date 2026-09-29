$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 70 x 25 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
leg_a = 70;               // horizontal leg, X
leg_b = 40;               // vertical leg, Z
depth = 25;               // bracket depth, Y
thick = 6;                // plate thickness
hole_d = 5.5;             // clearance for M5

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = thick + 1, d = hole_d);
}
module hole_x(pz, py) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = thick + 1, d = hole_d);
}

difference() {
  union() {
    /* horizontal leg */
    cube([leg_a, depth, thick]);
    /* vertical leg, overlapping the corner block */
    cube([thick, depth, leg_b]);
  }
  hole_z(11, 12.5);
  hole_z(59, 12.5);
  hole_x(11, 12.5);
  hole_x(29, 12.5);
}
