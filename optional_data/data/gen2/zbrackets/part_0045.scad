$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 55 x 25 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
lower_len = 55;           // lower foot length, X
upper_len = 43;           // upper foot length, X
width = 25;               // bracket width, Y
rise = 25;                // overall rise, Z
thick = 6;                // plate thickness
hole_d = 4.5;             // clearance for M4

module hole_z(px, py, z0) {
  translate([px, py, z0 - 2.5]) cylinder(h = thick + 5, d = hole_d);
}
module hole_x(py, pz) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = thick + 5, d = hole_d);
}

difference() {
  union() {
    cube([lower_len, width, thick]);
    /* web, overlapping the lower foot */
    translate([lower_len - thick, 0, 0]) cube([thick, width, rise]);
    /* upper foot, sunk into the web */
    translate([lower_len - thick - upper_len, 0, rise - thick]) cube([upper_len + thick, width, thick]);
  }
  hole_z(9, 12.5, 0);
  translate([lower_len - thick - 25.8, 0, 0]) hole_z(0, 12.5, rise - thick);
  translate([lower_len - thick, 0, 0]) hole_x(12.5, 12.5);
}
