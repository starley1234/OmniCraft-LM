$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 60 x 16 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_len = 60;            // horizontal leg, X
upright_h = 60;           // vertical leg, Z
flange_w = 16;            // bracket depth, Y
mat_t = 4.5;              // plate thickness
hole_d = 4.5;             // clearance for M4
cb_d = 8;                 // counterbore seat
cb_h = 2.4;               // counterbore depth
rib_leg = 34.2;           // gusset leg
rib_sink = 0.9;           // gusset overlap into the plates

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = mat_t + 1, d = hole_d);
}
module hole_x(pz, py) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = mat_t + 1, d = hole_d);
}
module cb_z(px, py) {
  translate([px, py, mat_t - cb_h]) cylinder(h = cb_h + 0.4, d = cb_d);
}
module cb_x(pz, py) {
  translate([mat_t - cb_h, py, pz]) rotate([0, -90, 0]) cylinder(h = cb_h + 0.4, d = cb_d);
}
module gusset() {
  translate([0, flange_w - rib_sink, 0])
    rotate([90, 0, 0])
      linear_extrude(height = flange_w - 2 * rib_sink)
        polygon(points = [[rib_sink, rib_sink], [rib_leg, rib_sink], [rib_sink, rib_leg]]);
}

difference() {
  union() {
    /* horizontal leg */
    cube([base_len, flange_w, mat_t]);
    /* vertical leg, overlapping the corner block */
    cube([mat_t, flange_w, upright_h]);
    gusset();
  }
  hole_z(9, 8);
  cb_z(9, 8);
  hole_z(51, 8);
  cb_z(51, 8);
  hole_x(9, 8);
  cb_x(9, 8);
  hole_x(51, 8);
  cb_x(51, 8);
}
