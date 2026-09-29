$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 55 x 35 x 30 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
lower_leg = 55;           // lower foot length, X
upper_leg = 40;           // upper foot length, X
bracket_w = 35;           // bracket width, Y
offset_h = 30;            // overall rise, Z
sheet_t = 4;              // plate thickness
hole_d = 3.4;             // clearance for M3
rib_len = 11.1;           // gusset leg
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
  hole_z(6.8, 17.5, 0);
  translate([lower_leg - sheet_t - 24, 0, 0]) hole_z(0, 17.5, offset_h - sheet_t);
  translate([lower_leg - sheet_t, 0, 0]) hole_x(17.5, 6.8);
}
