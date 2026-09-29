$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 45 x 20 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
arm_x = 45;               // horizontal leg, X
arm_z = 50;               // vertical leg, Z
width = 20;               // bracket depth, Y
wall = 3.5;               // plate thickness
hole_d = 6.6;             // clearance for M6
slot_l = 16;              // adjustment slot length
rib_leg = 22.1;           // gusset leg
rib_sink = 1.6;           // gusset overlap into the plates

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = wall + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = wall + 5, d = hole_d);
}
module adjust_slot(px, py) {
  hull() {
    translate([px - (slot_l - hole_d) / 2, py, -2.5]) cylinder(h = wall + 5, d = hole_d);
    translate([px + (slot_l - hole_d) / 2, py, -2.5]) cylinder(h = wall + 5, d = hole_d);
  }
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
  adjust_slot(22.5, 10);
  hole_x(25, 10);
}
