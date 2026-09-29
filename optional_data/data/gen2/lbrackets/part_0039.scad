$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 60 x 20 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
arm_x = 60;               // horizontal leg, X
arm_z = 50;               // vertical leg, Z
width = 20;               // bracket depth, Y
wall = 5;                 // plate thickness
hole_d = 4.5;             // clearance for M4
cb_d = 8;                 // counterbore seat
cb_h = 2.4;               // counterbore depth

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = wall + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = wall + 5, d = hole_d);
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
  hole_z(9, 10);
  cb_z(9, 10);
  hole_z(51, 10);
  cb_z(51, 10);
  hole_x(9, 10);
  cb_x(9, 10);
  hole_x(41, 10);
  cb_x(41, 10);
}
