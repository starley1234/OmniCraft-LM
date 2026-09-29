$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 30 x 25 x 45 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_len = 30;            // horizontal leg, X
upright_h = 45;           // vertical leg, Z
flange_w = 25;            // bracket depth, Y
mat_t = 4;                // plate thickness
hole_d = 9;               // clearance for M8

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = mat_t + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = mat_t + 5, d = hole_d);
}

difference() {
  union() {
    /* horizontal leg */
    cube([base_len, flange_w, mat_t]);
    /* vertical leg, overlapping the corner block */
    cube([mat_t, flange_w, upright_h]);
  }
  hole_z(15, 12.5);
  hole_x(22.5, 12.5);
}
