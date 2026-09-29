$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 70 x 20 x 35 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
lower_leg = 70;           // lower foot length, X
upper_leg = 35;           // upper foot length, X
bracket_w = 20;           // bracket width, Y
offset_h = 35;            // overall rise, Z
sheet_t = 3;              // plate thickness
hole_d = 6.6;             // clearance for M6
rib_len = 12.9;           // gusset leg
rib_sink = 0.9;           // gusset overlap into the plates

module hole_z(px, py, z0) {
  translate([px, py, z0 - 0.5]) cylinder(h = sheet_t + 1, d = hole_d);
}
module hole_x(py, pz) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = sheet_t + 1, d = hole_d);
}
module gusset(x0) {
  translate([x0, bracket_w - rib_sink, 0])
    rotate([90, 0, 0])
      linear_extrude(height = bracket_w - 2 * rib_sink)
        polygon(points = [[rib_sink, sheet_t - rib_sink],
                          [rib_sink, sheet_t - rib_sink + rib_len],
                          [-rib_len, sheet_t - rib_sink]]);
}

difference() {
  union() {
    cube([lower_leg, bracket_w, sheet_t]);
    /* web, overlapping the lower foot */
    translate([lower_leg - sheet_t, 0, 0]) cube([sheet_t, bracket_w, offset_h]);
    /* upper foot, sunk into the web */
    translate([lower_leg - sheet_t - upper_leg, 0, offset_h - sheet_t]) cube([upper_leg + sheet_t, bracket_w, sheet_t]);
    gusset(lower_leg - sheet_t);
  }
  hole_z(13.2, 10, 0);
  translate([lower_leg - sheet_t - 21, 0, 0]) hole_z(0, 10, offset_h - sheet_t);
  translate([lower_leg - sheet_t, 0, 0]) hole_x(10, 13.2);
}
