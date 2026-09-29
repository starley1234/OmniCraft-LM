$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 50 x 30 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_len = 50;            // horizontal leg, X
upright_h = 60;           // vertical leg, Z
flange_w = 30;            // bracket depth, Y
mat_t = 3;                // plate thickness
hole_d = 6.6;             // clearance for M6

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = mat_t + 1, d = hole_d);
}
module hole_x(pz, py) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = mat_t + 1, d = hole_d);
}

difference() {
  union() {
    /* horizontal leg */
    cube([base_len, flange_w, mat_t]);
    /* vertical leg, overlapping the corner block */
    cube([mat_t, flange_w, upright_h]);
  }
  hole_z(25, 15);
  hole_x(30, 15);
}
