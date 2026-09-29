$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 35 x 16 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
arm_x = 35;               // horizontal leg, X
arm_z = 25;               // vertical leg, Z
width = 16;               // bracket depth, Y
wall = 3;                 // plate thickness
hole_d = 4.5;             // clearance for M4
slot_l = 16;              // adjustment slot length

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = wall + 1, d = hole_d);
}
module hole_x(pz, py) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = wall + 1, d = hole_d);
}
module adjust_slot(px, py) {
  hull() {
    translate([px - (slot_l - hole_d) / 2, py, -0.5]) cylinder(h = wall + 1, d = hole_d);
    translate([px + (slot_l - hole_d) / 2, py, -0.5]) cylinder(h = wall + 1, d = hole_d);
  }
}

difference() {
  union() {
    /* horizontal leg */
    cube([arm_x, width, wall]);
    /* vertical leg, overlapping the corner block */
    cube([wall, width, arm_z]);
  }
  adjust_slot(17.5, 8);
  hole_x(12.5, 8);
}
