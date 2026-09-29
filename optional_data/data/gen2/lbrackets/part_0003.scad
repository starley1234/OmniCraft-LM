$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 65 x 30 x 55 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
arm_x = 65;               // horizontal leg, X
arm_z = 55;               // vertical leg, Z
width = 30;               // bracket depth, Y
wall = 5;                 // plate thickness
hole_d = 5.5;             // clearance for M5
rib_leg = 28.1;           // gusset leg
rib_sink = 1.6;           // gusset overlap into the plates

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = wall + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = wall + 5, d = hole_d);
}
module gusset() {
  translate([0, width - rib_sink, 0])
    rotate([90, 0, 0])
      linear_extrude(height = width - 2 * rib_sink)
        polygon(points = [[rib_sink, rib_sink], [rib_leg, rib_sink], [rib_sink, rib_leg]]);
}

difference() {
  union() {
    /* horizontal leg */
    cube([arm_x, width, wall]);
    /* vertical leg, overlapping the corner block */
    cube([wall, width, arm_z]);
    gusset();
  }
  hole_z(11, 15);
  hole_z(54, 15);
  hole_x(11, 15);
  hole_x(44, 15);
}
