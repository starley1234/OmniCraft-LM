$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 45 x 32 x 45 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_len = 45;            // horizontal leg, X
upright_h = 45;           // vertical leg, Z
flange_w = 32;            // bracket depth, Y
mat_t = 3.5;              // plate thickness
hole_d = 3.4;             // clearance for M3
slot_l = 20;              // adjustment slot length

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = mat_t + 1, d = hole_d);
}
module hole_x(pz, py) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = mat_t + 1, d = hole_d);
}
module adjust_slot(px, py) {
  hull() {
    translate([px - (slot_l - hole_d) / 2, py, -0.5]) cylinder(h = mat_t + 1, d = hole_d);
    translate([px + (slot_l - hole_d) / 2, py, -0.5]) cylinder(h = mat_t + 1, d = hole_d);
  }
}

difference() {
  union() {
    /* horizontal leg */
    cube([base_len, flange_w, mat_t]);
    /* vertical leg, overlapping the corner block */
    cube([mat_t, flange_w, upright_h]);
  }
  adjust_slot(22.5, 16);
  hole_x(22.5, 16);
}
