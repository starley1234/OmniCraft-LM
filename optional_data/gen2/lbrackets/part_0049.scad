$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 30 x 40 x 55 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
run_out = 30;             // horizontal leg, X
rise = 55;                // vertical leg, Z
bracket_w = 40;           // bracket depth, Y
sheet_t = 6;              // plate thickness
hole_d = 6.6;             // clearance for M6
cb_d = 11;                // counterbore seat
cb_h = 3.4;               // counterbore depth

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = sheet_t + 1, d = hole_d);
}
module hole_x(pz, py) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = sheet_t + 1, d = hole_d);
}
module cb_z(px, py) {
  translate([px, py, sheet_t - cb_h]) cylinder(h = cb_h + 0.4, d = cb_d);
}
module cb_x(pz, py) {
  translate([sheet_t - cb_h, py, pz]) rotate([0, -90, 0]) cylinder(h = cb_h + 0.4, d = cb_d);
}

difference() {
  union() {
    /* horizontal leg */
    cube([run_out, bracket_w, sheet_t]);
    /* vertical leg, overlapping the corner block */
    cube([sheet_t, bracket_w, rise]);
  }
  hole_z(15, 20);
  cb_z(15, 20);
  hole_x(13.2, 20);
  cb_x(13.2, 20);
  hole_x(41.8, 20);
  cb_x(41.8, 20);
}
