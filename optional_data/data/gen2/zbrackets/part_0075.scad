$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 50 x 20 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
lower_len = 50;           // lower foot length, X
upper_len = 25;           // upper foot length, X
width = 20;               // bracket width, Y
rise = 25;                // overall rise, Z
thick = 5;                // plate thickness
hole_d = 9;               // clearance for M8
cb_d = 14.5;              // counterbore diameter
cb_h = 3.2;               // counterbore depth

module hole_z(px, py, z0) {
  translate([px, py, z0 - 2.5]) cylinder(h = thick + 5, d = hole_d);
}
module hole_x(py, pz) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = thick + 5, d = hole_d);
}
module cb_z(px, py, top_z) {
  translate([px, py, top_z - cb_h]) cylinder(h = cb_h + 0.5, d = cb_d);
}
module cb_x(py, pz) {
  translate([thick - cb_h, py, pz]) rotate([0, -90, 0]) cylinder(h = cb_h + 0.5, d = cb_d);
}

difference() {
  union() {
    cube([lower_len, width, thick]);
    /* web, overlapping the lower foot */
    translate([lower_len - thick, 0, 0]) cube([thick, width, rise]);
    /* upper foot, sunk into the web */
    translate([lower_len - thick - upper_len, 0, rise - thick]) cube([upper_len + thick, width, thick]);
  }
  hole_z(18, 10, 0);
  translate([lower_len - thick - 7, 0, 0]) hole_z(0, 10, rise - thick);
  translate([lower_len - thick, 0, 0]) hole_x(10, 12.5);
  cb_z(18, 10, thick);
  translate([lower_len - thick - 7, 0, 0]) cb_z(0, 10, rise);
  translate([lower_len - thick, 0, 0]) cb_x(10, 12.5);
}
