$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 30 x 20 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_len = 30;            // horizontal leg, X
upright_h = 25;           // vertical leg, Z
flange_w = 20;            // bracket depth, Y
mat_t = 3.5;              // plate thickness
hole_d = 4.5;             // clearance for M4

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
  hole_z(15, 10);
  hole_x(12.5, 10);
}
