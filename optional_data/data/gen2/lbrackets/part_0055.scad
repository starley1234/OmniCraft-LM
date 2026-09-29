$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 35 x 16 x 70 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
leg_a = 35;               // horizontal leg, X
leg_b = 70;               // vertical leg, Z
depth = 16;               // bracket depth, Y
thick = 4.5;              // plate thickness
hole_d = 5.5;             // clearance for M5
cb_d = 9.5;               // counterbore seat
cb_h = 2.7;               // counterbore depth

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = thick + 1, d = hole_d);
}
module hole_x(pz, py) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = thick + 1, d = hole_d);
}
module cb_z(px, py) {
  translate([px, py, thick - cb_h]) cylinder(h = cb_h + 0.4, d = cb_d);
}
module cb_x(pz, py) {
  translate([thick - cb_h, py, pz]) rotate([0, -90, 0]) cylinder(h = cb_h + 0.4, d = cb_d);
}

difference() {
  union() {
    /* horizontal leg */
    cube([leg_a, depth, thick]);
    /* vertical leg, overlapping the corner block */
    cube([thick, depth, leg_b]);
  }
  hole_z(11, 8);
  cb_z(11, 8);
  hole_z(24, 8);
  cb_z(24, 8);
  hole_x(11, 8);
  cb_x(11, 8);
  hole_x(59, 8);
  cb_x(59, 8);
}
