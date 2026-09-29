$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 90 x 25 x 35 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
run_out = 90;             // horizontal leg, X
rise = 35;                // vertical leg, Z
bracket_w = 25;           // bracket depth, Y
sheet_t = 4;              // plate thickness
hole_d = 6.6;             // clearance for M6

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
  hole_z(45, 12.5);
  hole_x(17.5, 12.5);
}
