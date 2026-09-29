$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 45 x 20 x 45 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_len = 45;            // horizontal leg, X
upright_h = 45;           // vertical leg, Z
flange_w = 20;            // bracket depth, Y
mat_t = 3;                // plate thickness
hole_d = 9;               // clearance for M8
rib_leg = 18.9;           // gusset leg
rib_sink = 0.9;           // gusset overlap into the plates

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = mat_t + 1, d = hole_d);
}
module hole_x(pz, py) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = mat_t + 1, d = hole_d);
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
  hole_z(22.5, 10);
  hole_x(22.5, 10);
}
