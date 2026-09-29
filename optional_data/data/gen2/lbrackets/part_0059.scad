$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 40 x 32 x 55 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_len = 40;            // horizontal leg, X
upright_h = 55;           // vertical leg, Z
flange_w = 32;            // bracket depth, Y
mat_t = 4;                // plate thickness
hole_d = 3.4;             // clearance for M3
rib_leg = 18.8;           // gusset leg
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
  hole_z(6.8, 16);
  hole_z(33.2, 16);
  hole_x(6.8, 16);
  hole_x(48.2, 16);
}
