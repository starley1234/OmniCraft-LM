$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 30 x 25 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_len = 30;            // horizontal leg, X
upright_h = 25;           // vertical leg, Z
flange_w = 25;            // bracket depth, Y
mat_t = 6;                // plate thickness
hole_d = 4.5;             // clearance for M4
slot_w = 5.5;             // euro screw slot width
slot_l = 13;              // euro screw slot length

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = mat_t + 1, d = hole_d);
}
module hole_x(pz, py) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = mat_t + 1, d = hole_d);
}
module euro_slot_z(px, py) {
  hull() {
    translate([px - (slot_l - slot_w) / 2, py, -0.5]) cylinder(h = mat_t + 1, d = slot_w);
    translate([px + (slot_l - slot_w) / 2, py, -0.5]) cylinder(h = mat_t + 1, d = slot_w);
  }
}
module euro_slot_x(pz, py) {
  translate([-0.5, 0, 0]) rotate([0, 90, 0]) hull() {
    translate([0, py, pz - (slot_l - slot_w) / 2]) cylinder(h = mat_t + 1, d = slot_w);
    translate([0, py, pz + (slot_l - slot_w) / 2]) cylinder(h = mat_t + 1, d = slot_w);
  }
}

difference() {
  union() {
    /* horizontal leg */
    cube([base_len, flange_w, mat_t]);
    /* vertical leg, overlapping the corner block */
    cube([mat_t, flange_w, upright_h]);
  }
  euro_slot_z(10, 12.5);
  euro_slot_x(10, 12.5);
}
