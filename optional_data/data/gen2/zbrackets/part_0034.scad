$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 70 x 25 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
lower_len = 70;           // lower foot length, X
upper_len = 35;           // upper foot length, X
width = 25;               // bracket width, Y
rise = 25;                // overall rise, Z
thick = 6;                // plate thickness
hole_d = 5.5;             // clearance for M5
cb_d = 9.5;               // counterbore diameter
cb_h = 2.9;               // counterbore depth
rib_len = 11;             // gusset leg
rib_sink = 1.6;           // gusset overlap into the plates

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
  hole_z(11, 12.5, 0);
  translate([lower_len - thick - 21, 0, 0]) hole_z(0, 12.5, rise - thick);
  cb_z(11, 12.5, thick);
  translate([lower_len - thick - 21, 0, 0]) cb_z(0, 12.5, rise);
}
