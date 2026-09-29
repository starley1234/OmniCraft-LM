$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 100 x 40 x 30 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
run_out = 100;            // horizontal leg, X
rise = 30;                // vertical leg, Z
bracket_w = 40;           // bracket depth, Y
sheet_t = 4.5;            // plate thickness
hole_d = 4.5;             // clearance for M4
cb_d = 8;                 // counterbore seat
cb_h = 2.4;               // counterbore depth

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = sheet_t + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = sheet_t + 5, d = hole_d);
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
  hole_z(9, 20);
  cb_z(9, 20);
  hole_z(91, 20);
  cb_z(91, 20);
  hole_x(9, 20);
  cb_x(9, 20);
  hole_x(21, 20);
  cb_x(21, 20);
}
