$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 45 x 30 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
arm_x = 45;               // horizontal leg, X
arm_z = 40;               // vertical leg, Z
width = 30;               // bracket depth, Y
wall = 5;                 // plate thickness
hole_d = 3.4;             // clearance for M3
cb_d = 6;                 // counterbore seat
cb_h = 1.9;               // counterbore depth

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = wall + 1, d = hole_d);
}
module hole_x(pz, py) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = wall + 1, d = hole_d);
}
module cb_z(px, py) {
  translate([px, py, wall - cb_h]) cylinder(h = cb_h + 0.4, d = cb_d);
}
module cb_x(pz, py) {
  translate([wall - cb_h, py, pz]) rotate([0, -90, 0]) cylinder(h = cb_h + 0.4, d = cb_d);
}

difference() {
  union() {
    /* horizontal leg */
    cube([arm_x, width, wall]);
    /* vertical leg, overlapping the corner block */
    cube([wall, width, arm_z]);
  }
  hole_z(22.5, 15);
  cb_z(22.5, 15);
  hole_x(20, 15);
  cb_x(20, 15);
}
