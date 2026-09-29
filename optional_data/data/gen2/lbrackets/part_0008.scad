$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 100 x 16 x 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
arm_x = 100;              // horizontal leg, X
arm_z = 80;               // vertical leg, Z
width = 16;               // bracket depth, Y
wall = 3.5;               // plate thickness
hole_d = 4.5;             // clearance for M4
slot_w = 5.5;             // euro screw slot width
slot_l = 13;              // euro screw slot length
rib_leg = 35.2;           // gusset leg
rib_sink = 1.6;           // gusset overlap into the plates

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = wall + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = wall + 5, d = hole_d);
}
module euro_slot_z(px, py) {
  hull() {
    translate([px - (slot_l - slot_w) / 2, py, -2.5]) cylinder(h = wall + 5, d = slot_w);
    translate([px + (slot_l - slot_w) / 2, py, -2.5]) cylinder(h = wall + 5, d = slot_w);
  }
}
module euro_slot_x(pz, py) {
  translate([-2.5, 0, 0]) rotate([0, 90, 0]) hull() {
    translate([0, py, pz - (slot_l - slot_w) / 2]) cylinder(h = wall + 5, d = slot_w);
    translate([0, py, pz + (slot_l - slot_w) / 2]) cylinder(h = wall + 5, d = slot_w);
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
  euro_slot_z(10, 8);
  euro_slot_x(10, 8);
  euro_slot_z(90, 8);
}
