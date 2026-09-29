$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 40 x 25 x 35 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
run_out = 40;             // horizontal leg, X
rise = 35;                // vertical leg, Z
bracket_w = 25;           // bracket depth, Y
sheet_t = 6;              // plate thickness
hole_d = 5.5;             // clearance for M5
slot_l = 16;              // adjustment slot length

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = sheet_t + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = sheet_t + 5, d = hole_d);
}
module adjust_slot(px, py) {
  hull() {
    translate([px - (slot_l - hole_d) / 2, py, -2.5]) cylinder(h = sheet_t + 5, d = hole_d);
    translate([px + (slot_l - hole_d) / 2, py, -2.5]) cylinder(h = sheet_t + 5, d = hole_d);
  }
}

difference() {
  union() {
    /* horizontal leg */
    cube([run_out, bracket_w, sheet_t]);
    /* vertical leg, overlapping the corner block */
    cube([sheet_t, bracket_w, rise]);
  }
  adjust_slot(20, 12.5);
  hole_x(17.5, 12.5);
}
