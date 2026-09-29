$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 100 x 16 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
arm_x = 100;              // horizontal leg, X
arm_z = 60;               // vertical leg, Z
width = 16;               // bracket depth, Y
wall = 4.5;               // plate thickness
hole_d = 9;               // clearance for M8
cb_d = 14.5;              // counterbore seat
cb_h = 2.7;               // counterbore depth

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
  hole_z(50, 8);
  cb_z(50, 8);
  hole_x(30, 8);
  cb_x(30, 8);
}
