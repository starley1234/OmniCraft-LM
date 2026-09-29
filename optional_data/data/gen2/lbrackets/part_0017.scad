$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 65 x 25 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
leg_a = 65;               // horizontal leg, X
leg_b = 50;               // vertical leg, Z
depth = 25;               // bracket depth, Y
thick = 5;                // plate thickness
hole_d = 3.4;             // clearance for M3

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
  hole_z(32.5, 12.5);
  hole_x(25, 12.5);
}
