$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 30 x 25 x 45 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
run_out = 30;             // horizontal leg, X
rise = 45;                // vertical leg, Z
bracket_w = 25;           // bracket depth, Y
sheet_t = 4;              // plate thickness
hole_d = 5.5;             // clearance for M5

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
  hole_z(15, 12.5);
  hole_x(11, 12.5);
  hole_x(34, 12.5);
}
