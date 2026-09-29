$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 80 x 32 x 45 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
arm_x = 80;               // horizontal leg, X
arm_z = 45;               // vertical leg, Z
width = 32;               // bracket depth, Y
wall = 6;                 // plate thickness
hole_d = 9;               // clearance for M8
slot_w = 5.5;             // euro screw slot width
slot_l = 13;              // euro screw slot length

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

difference() {
  union() {
    /* horizontal leg */
    cube([arm_x, width, wall]);
    /* vertical leg, overlapping the corner block */
    cube([wall, width, arm_z]);
  }
  euro_slot_z(18, 16);
  euro_slot_x(18, 16);
  euro_slot_z(62, 16);
}
