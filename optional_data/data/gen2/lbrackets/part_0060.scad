$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 60 x 25 x 30 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
horiz_len = 60;           // horizontal leg, X
vert_len = 30;            // vertical leg, Z
profile_w = 25;           // bracket depth, Y
plate_t = 4.5;            // plate thickness
hole_d = 5.5;             // clearance for M5
slot_w = 5.5;             // euro screw slot width
slot_l = 13;              // euro screw slot length

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = plate_t + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = plate_t + 5, d = hole_d);
}
module euro_slot_z(px, py) {
  hull() {
    translate([px - (slot_l - slot_w) / 2, py, -2.5]) cylinder(h = plate_t + 5, d = slot_w);
    translate([px + (slot_l - slot_w) / 2, py, -2.5]) cylinder(h = plate_t + 5, d = slot_w);
  }
}
module euro_slot_x(pz, py) {
  translate([-2.5, 0, 0]) rotate([0, 90, 0]) hull() {
    translate([0, py, pz - (slot_l - slot_w) / 2]) cylinder(h = plate_t + 5, d = slot_w);
    translate([0, py, pz + (slot_l - slot_w) / 2]) cylinder(h = plate_t + 5, d = slot_w);
  }
}

difference() {
  union() {
    /* horizontal leg */
    cube([horiz_len, profile_w, plate_t]);
    /* vertical leg, overlapping the corner block */
    cube([plate_t, profile_w, vert_len]);
  }
  euro_slot_z(11, 12.5);
  euro_slot_x(11, 12.5);
  euro_slot_z(49, 12.5);
}
