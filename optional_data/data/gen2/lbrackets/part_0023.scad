$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 50 x 30 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_len = 50;            // horizontal leg, X
upright_h = 40;           // vertical leg, Z
flange_w = 30;            // bracket depth, Y
mat_t = 5;                // plate thickness
hole_d = 5.5;             // clearance for M5
rib_leg = 17.2;           // gusset leg
rib_sink = 1.6;           // gusset overlap into the plates

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = mat_t + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = mat_t + 5, d = hole_d);
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
  hole_z(11, 15);
  hole_z(39, 15);
  hole_x(11, 15);
  hole_x(29, 15);
}
