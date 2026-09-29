$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 50 x 40 x 35 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
lower_leg = 50;           // lower foot length, X
upper_leg = 42;           // upper foot length, X
bracket_w = 40;           // bracket width, Y
offset_h = 35;            // overall rise, Z
sheet_t = 4;              // plate thickness
hole_d = 9;               // clearance for M8

module hole_z(px, py, z0) {
  translate([px, py, z0 - 0.5]) cylinder(h = sheet_t + 1, d = hole_d);
}
module hole_x(py, pz) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = sheet_t + 1, d = hole_d);
}

difference() {
  union() {
    cube([lower_leg, bracket_w, sheet_t]);
    /* web, overlapping the lower foot */
    translate([lower_leg - sheet_t, 0, 0]) cube([sheet_t, bracket_w, offset_h]);
    /* upper foot, sunk into the web */
    translate([lower_leg - sheet_t - upper_leg, 0, offset_h - sheet_t]) cube([upper_leg + sheet_t, bracket_w, sheet_t]);
  }
  hole_z(18, 20, 0);
  translate([lower_leg - sheet_t - 24, 0, 0]) hole_z(0, 20, offset_h - sheet_t);
  translate([lower_leg - sheet_t, 0, 0]) hole_x(20, 18);
}
