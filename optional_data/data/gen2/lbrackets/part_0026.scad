$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 65 x 20 x 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_len = 65;            // horizontal leg, X
upright_h = 80;           // vertical leg, Z
flange_w = 20;            // bracket depth, Y
mat_t = 5;                // plate thickness
hole_d = 5.5;             // clearance for M5
slot_l = 16;              // adjustment slot length

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
  adjust_slot(32.5, 10);
  hole_x(40, 10);
}
