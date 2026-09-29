$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 55 x 24 x 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_len = 55;            // horizontal leg, X
upright_h = 80;           // vertical leg, Z
flange_w = 24;            // bracket depth, Y
mat_t = 6;                // plate thickness
hole_d = 9;               // clearance for M8
cb_d = 14.5;              // counterbore seat
cb_h = 4.2;               // counterbore depth

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = mat_t + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = mat_t + 5, d = hole_d);
}
module cb_z(px, py) {
  translate([px, py, mat_t - cb_h]) cylinder(h = cb_h + 0.4, d = cb_d);
}
module cb_x(pz, py) {
  translate([mat_t - cb_h, py, pz]) rotate([0, -90, 0]) cylinder(h = cb_h + 0.4, d = cb_d);
}

difference() {
  union() {
    /* horizontal leg */
    cube([base_len, flange_w, mat_t]);
    /* vertical leg, overlapping the corner block */
    cube([mat_t, flange_w, upright_h]);
  }
  hole_z(27.5, 12);
  cb_z(27.5, 12);
  hole_x(40, 12);
  cb_x(40, 12);
}
