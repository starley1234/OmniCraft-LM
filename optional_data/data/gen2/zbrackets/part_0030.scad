$fn = 32;

// ----------------------------------------------------------------------
// Z-bracket: 45 x 25 x 35 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
lower_leg = 45;           // lower foot length, X
upper_leg = 35;           // upper foot length, X
bracket_w = 25;           // bracket width, Y
offset_h = 35;            // overall rise, Z
sheet_t = 5;              // plate thickness
hole_d = 9;               // clearance for M8
cb_d = 14.5;              // counterbore diameter
cb_h = 3.2;               // counterbore depth
rib_len = 12.2;           // gusset leg
rib_sink = 1.6;           // gusset overlap into the plates

module hole_z(px, py, z0) {
  translate([px, py, z0 - 2.5]) cylinder(h = sheet_t + 5, d = hole_d);
}
module hole_x(py, pz) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = sheet_t + 5, d = hole_d);
}
module cb_z(px, py, top_z) {
  translate([px, py, top_z - cb_h]) cylinder(h = cb_h + 0.5, d = cb_d);
}
module cb_x(py, pz) {
  translate([sheet_t - cb_h, py, pz]) rotate([0, -90, 0]) cylinder(h = cb_h + 0.5, d = cb_d);
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
  hole_z(18, 12.5, 0);
  translate([lower_leg - sheet_t - 17, 0, 0]) hole_z(0, 12.5, offset_h - sheet_t);
  translate([lower_leg - sheet_t, 0, 0]) hole_x(12.5, 21.55);
  cb_z(18, 12.5, sheet_t);
  translate([lower_leg - sheet_t - 17, 0, 0]) cb_z(0, 12.5, offset_h);
  translate([lower_leg - sheet_t, 0, 0]) cb_x(12.5, 21.55);
}
