$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 90 x 40 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
leg_a = 90;               // horizontal leg, X
leg_b = 50;               // vertical leg, Z
depth = 40;               // bracket depth, Y
thick = 3.5;              // plate thickness
hole_d = 6.6;             // clearance for M6
slot_l = 20;              // adjustment slot length
rib_leg = 28.5;           // gusset leg
rib_sink = 0.9;           // gusset overlap into the plates

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = thick + 1, d = hole_d);
}
module hole_x(pz, py) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = thick + 1, d = hole_d);
}
module adjust_slot(px, py) {
  hull() {
    translate([px - (slot_l - hole_d) / 2, py, -0.5]) cylinder(h = thick + 1, d = hole_d);
    translate([px + (slot_l - hole_d) / 2, py, -0.5]) cylinder(h = thick + 1, d = hole_d);
  }
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
  adjust_slot(45, 20);
  hole_x(25, 20);
}
