$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 100 x 30 x 30 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
run_out = 100;            // horizontal leg, X
rise = 30;                // vertical leg, Z
bracket_w = 30;           // bracket depth, Y
sheet_t = 3.5;            // plate thickness
hole_d = 9;               // clearance for M8

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = sheet_t + 1, d = hole_d);
}
module hole_x(pz, py) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = sheet_t + 1, d = hole_d);
}

difference() {
  union() {
    /* horizontal leg */
    cube([run_out, bracket_w, sheet_t]);
    /* vertical leg, overlapping the corner block */
    cube([sheet_t, bracket_w, rise]);
  }
  hole_z(18, 15);
  hole_z(82, 15);
  hole_x(15, 15);
}
