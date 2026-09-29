$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 45 x 40 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
lower_len = 45;           // lower foot length, X
upper_len = 35;           // upper foot length, X
width = 40;               // bracket width, Y
rise = 40;                // overall rise, Z
thick = 5;                // plate thickness
hole_d = 4.5;             // clearance for M4

module hole_z(px, py, z0) {
  translate([px, py, z0 - 0.5]) cylinder(h = thick + 1, d = hole_d);
}
module hole_x(py, pz) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = thick + 1, d = hole_d);
}

difference() {
  union() {
    cube([lower_len, width, thick]);
    /* web, overlapping the lower foot */
    translate([lower_len - thick, 0, 0]) cube([thick, width, rise]);
    /* upper foot, sunk into the web */
    translate([lower_len - thick - upper_len, 0, rise - thick]) cube([upper_len + thick, width, thick]);
  }
  hole_z(9, 20, 0);
  translate([lower_len - thick - 21, 0, 0]) hole_z(0, 20, rise - thick);
  translate([lower_len - thick, 0, 0]) hole_x(20, 9);
}
