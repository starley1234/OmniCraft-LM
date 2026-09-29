$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 30 x 40 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
arm_x = 30;               // horizontal leg, X
arm_z = 25;               // vertical leg, Z
width = 40;               // bracket depth, Y
wall = 4.5;               // plate thickness
hole_d = 9;               // clearance for M8
cb_d = 14.5;              // counterbore seat
cb_h = 2.7;               // counterbore depth

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
  hole_z(15, 20);
  cb_z(15, 20);
  hole_x(12.5, 20);
  cb_x(12.5, 20);
}
