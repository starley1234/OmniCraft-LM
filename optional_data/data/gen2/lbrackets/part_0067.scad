$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 55 x 40 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
run_out = 55;             // horizontal leg, X
rise = 25;                // vertical leg, Z
bracket_w = 40;           // bracket depth, Y
sheet_t = 3;              // plate thickness
hole_d = 4.5;             // clearance for M4

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = sheet_t + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = sheet_t + 5, d = hole_d);
}

difference() {
  union() {
    /* horizontal leg */
    cube([run_out, bracket_w, sheet_t]);
    /* vertical leg, overlapping the corner block */
    cube([sheet_t, bracket_w, rise]);
  }
  hole_z(9, 20);
  hole_z(46, 20);
  hole_x(12.5, 20);
}
