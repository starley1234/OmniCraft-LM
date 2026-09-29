$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 55 x 30 x 35 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_len = 55;            // outer length, X
channel_w = 30;           // outer width, Y
upright_h = 35;           // upright height, Z
mat_t = 6;                // wall thickness
hole_d = 5.5;             // clearance for M5
slot_l = 20;              // slot length

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = mat_t + 1, d = hole_d);
}
module hole_y_pz(pz) {
  /* through both uprights along Y */
  translate([0, -0.5, pz]) rotate([-90, 0, 0]) cylinder(h = channel_w + 1, d = hole_d);
}
module slot_z(px, py) {
  hull() {
    translate([px - (slot_l - hole_d) / 2, py, -0.5]) cylinder(h = mat_t + 1, d = hole_d);
    translate([px + (slot_l - hole_d) / 2, py, -0.5]) cylinder(h = mat_t + 1, d = hole_d);
  }
}

module base() {
  cube([base_len, channel_w, mat_t]);
}

module uprights() {
  cube([base_len, mat_t, upright_h]);
  translate([0, channel_w - mat_t, 0]) cube([base_len, mat_t, upright_h]);
}

difference() {
  union() {
    base();
    uprights();
  }
  slot_z(27.5, 15);
}
