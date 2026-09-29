$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 100 x 24 x 35 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
run_out = 100;            // horizontal leg, X
rise = 35;                // vertical leg, Z
bracket_w = 24;           // bracket depth, Y
sheet_t = 6;              // plate thickness
hole_d = 9;               // clearance for M8
cb_d = 14.5;              // counterbore seat
cb_h = 4.2;               // counterbore depth

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
  hole_z(50, 12);
  cb_z(50, 12);
  hole_x(17.5, 12);
  cb_x(17.5, 12);
}
