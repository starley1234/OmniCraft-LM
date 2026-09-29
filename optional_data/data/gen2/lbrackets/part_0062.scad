$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 55 x 32 x 55 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
leg_a = 55;               // horizontal leg, X
leg_b = 55;               // vertical leg, Z
depth = 32;               // bracket depth, Y
thick = 4.5;              // plate thickness
hole_d = 3.4;             // clearance for M3
slot_l = 16;              // adjustment slot length
rib_leg = 25.3;           // gusset leg
rib_sink = 1.6;           // gusset overlap into the plates

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = thick + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = thick + 5, d = hole_d);
}
module adjust_slot(px, py) {
  hull() {
    translate([px - (slot_l - hole_d) / 2, py, -2.5]) cylinder(h = thick + 5, d = hole_d);
    translate([px + (slot_l - hole_d) / 2, py, -2.5]) cylinder(h = thick + 5, d = hole_d);
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
  adjust_slot(27.5, 16);
  hole_x(27.5, 16);
}
