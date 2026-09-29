$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 45 x 30 x 30 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
lower_leg = 45;           // lower foot length, X
upper_leg = 37;           // upper foot length, X
bracket_w = 30;           // bracket width, Y
offset_h = 30;            // overall rise, Z
sheet_t = 4;              // plate thickness
hole_d = 3.4;             // clearance for M3
rib_len = 12.6;           // gusset leg
rib_sink = 1.6;           // gusset overlap into the plates

module hole_z(px, py, z0) {
  translate([px, py, z0 - 2.5]) cylinder(h = sheet_t + 5, d = hole_d);
}
module hole_x(py, pz) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = sheet_t + 5, d = hole_d);
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
  hole_z(6.8, 15, 0);
  translate([lower_leg - sheet_t - 22.2, 0, 0]) hole_z(0, 15, offset_h - sheet_t);
  translate([lower_leg - sheet_t, 0, 0]) hole_x(15, 19.25);
}
