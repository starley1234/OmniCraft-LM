$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 100 x 40 x 35 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
leg_a = 100;              // horizontal leg, X
leg_b = 35;               // vertical leg, Z
depth = 40;               // bracket depth, Y
thick = 6;                // plate thickness
hole_d = 5.5;             // clearance for M5
slot_w = 5.5;             // euro screw slot width
slot_l = 13;              // euro screw slot length

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

difference() {
  union() {
    /* horizontal leg */
    cube([leg_a, depth, thick]);
    /* vertical leg, overlapping the corner block */
    cube([thick, depth, leg_b]);
  }
  euro_slot_z(11, 20);
  euro_slot_x(11, 20);
  euro_slot_z(89, 20);
}
