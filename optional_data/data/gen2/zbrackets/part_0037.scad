$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 80 x 40 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
lower_len = 80;           // lower foot length, X
upper_len = 40;           // upper foot length, X
width = 40;               // bracket width, Y
rise = 40;                // overall rise, Z
thick = 5;                // plate thickness
hole_d = 4.5;             // clearance for M4
rib_len = 15.6;           // gusset leg
rib_sink = 1.6;           // gusset overlap into the plates

module hole_z(px, py, z0) {
  translate([px, py, z0 - 2.5]) cylinder(h = thick + 5, d = hole_d);
}
module hole_x(py, pz) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = thick + 5, d = hole_d);
}
module gusset(x0) {
  translate([x0, width - rib_sink, 0])
    rotate([90, 0, 0])
      linear_extrude(height = width - 2 * rib_sink)
        polygon(points = [[rib_sink, thick - rib_sink],
                          [rib_sink, thick - rib_sink + rib_len],
                          [-rib_len, thick - rib_sink]]);
}

difference() {
  union() {
    cube([lower_len, width, thick]);
    /* web, overlapping the lower foot */
    translate([lower_len - thick, 0, 0]) cube([thick, width, rise]);
    /* upper foot, sunk into the web */
    translate([lower_len - thick - upper_len, 0, rise - thick]) cube([upper_len + thick, width, thick]);
    gusset(lower_len - thick);
  }
  hole_z(9, 20, 0);
  translate([lower_len - thick - 24, 0, 0]) hole_z(0, 20, rise - thick);
  translate([lower_len - thick, 0, 0]) hole_x(20, 25.75);
}
