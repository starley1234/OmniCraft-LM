$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 70 x 32 x 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
leg_a = 70;               // horizontal leg, X
leg_b = 80;               // vertical leg, Z
depth = 32;               // bracket depth, Y
thick = 3.5;              // plate thickness
hole_d = 4.5;             // clearance for M4
slot_w = 5.5;             // euro screw slot width
slot_l = 13;              // euro screw slot length
rib_leg = 30.1;           // gusset leg
rib_sink = 1.6;           // gusset overlap into the plates

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = thick + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = thick + 5, d = hole_d);
}
module euro_slot_z(px, py) {
  hull() {
    translate([px - (slot_l - slot_w) / 2, py, -2.5]) cylinder(h = thick + 5, d = slot_w);
    translate([px + (slot_l - slot_w) / 2, py, -2.5]) cylinder(h = thick + 5, d = slot_w);
  }
}
module euro_slot_x(pz, py) {
  translate([-2.5, 0, 0]) rotate([0, 90, 0]) hull() {
    translate([0, py, pz - (slot_l - slot_w) / 2]) cylinder(h = thick + 5, d = slot_w);
    translate([0, py, pz + (slot_l - slot_w) / 2]) cylinder(h = thick + 5, d = slot_w);
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
  euro_slot_z(10, 16);
  euro_slot_x(10, 16);
  euro_slot_z(60, 16);
}
