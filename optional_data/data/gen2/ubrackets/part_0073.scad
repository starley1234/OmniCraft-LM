$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 40 x 45 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_len = 40;            // outer length, X
channel_w = 45;           // outer width, Y
upright_h = 25;           // upright height, Z
mat_t = 8;                // wall thickness
hole_d = 9;               // clearance for M8
cb_d = 14.5;              // counterbore diameter
cb_h = 4.4;               // counterbore depth

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = mat_t + 5, d = hole_d);
}
module hole_y_pz(pz) {
  /* through both uprights along Y */
  translate([0, -2.5, pz]) rotate([-90, 0, 0]) cylinder(h = channel_w + 5, d = hole_d);
}
module cb_z(px, py) {
  translate([px, py, mat_t - cb_h]) cylinder(h = cb_h + 0.4, d = cb_d);
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
  hole_z(20, 22.5);
  cb_z(20, 22.5);
}
