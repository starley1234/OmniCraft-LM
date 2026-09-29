$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 55 x 40 x 55 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
run_out = 55;             // horizontal leg, X
rise = 55;                // vertical leg, Z
bracket_w = 40;           // bracket depth, Y
sheet_t = 6;              // plate thickness
hole_d = 3.4;             // clearance for M3
rib_leg = 26.9;           // gusset leg
rib_sink = 1.6;           // gusset overlap into the plates

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = sheet_t + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = sheet_t + 5, d = hole_d);
}
module gusset() {
  translate([0, bracket_w - rib_sink, 0])
    rotate([90, 0, 0])
      linear_extrude(height = bracket_w - 2 * rib_sink)
        polygon(points = [[rib_sink, rib_sink], [rib_leg, rib_sink], [rib_sink, rib_leg]]);
}

difference() {
  union() {
    /* horizontal leg */
    cube([run_out, bracket_w, sheet_t]);
    /* vertical leg, overlapping the corner block */
    cube([sheet_t, bracket_w, rise]);
    gusset();
  }
  hole_z(27.5, 20);
  hole_x(27.5, 20);
}
