$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 40 x 30 x 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
leg_a = 40;               // horizontal leg, X
leg_b = 40;               // vertical leg, Z
depth = 30;               // bracket depth, Y
thick = 4.5;              // plate thickness
hole_d = 5.5;             // clearance for M5
rib_leg = 19.2;           // gusset leg
rib_sink = 0.9;           // gusset overlap into the plates

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = thick + 1, d = hole_d);
}
module hole_x(pz, py) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = thick + 1, d = hole_d);
}
module gusset() {
  translate([0, depth - rib_sink, 0])
    rotate([90, 0, 0])
      linear_extrude(height = depth - 2 * rib_sink)
        polygon(points = [[rib_sink, rib_sink], [rib_leg, rib_sink], [rib_sink, rib_leg]]);
}

difference() {
  union() {
    /* horizontal leg */
    cube([leg_a, depth, thick]);
    /* vertical leg, overlapping the corner block */
    cube([thick, depth, leg_b]);
    gusset();
  }
  hole_z(20, 15);
  hole_x(20, 15);
}
