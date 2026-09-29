$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 80 x 32 x 70 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
horiz_len = 80;           // horizontal leg, X
vert_len = 70;            // vertical leg, Z
profile_w = 32;           // bracket depth, Y
plate_t = 3;              // plate thickness
hole_d = 6.6;             // clearance for M6
slot_w = 5.5;             // euro screw slot width
slot_l = 13;              // euro screw slot length

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = plate_t + 1, d = hole_d);
}
module hole_x(pz, py) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = plate_t + 1, d = hole_d);
}
module euro_slot_z(px, py) {
  hull() {
    translate([px - (slot_l - slot_w) / 2, py, -0.5]) cylinder(h = plate_t + 1, d = slot_w);
    translate([px + (slot_l - slot_w) / 2, py, -0.5]) cylinder(h = plate_t + 1, d = slot_w);
  }
}
module euro_slot_x(pz, py) {
  translate([-0.5, 0, 0]) rotate([0, 90, 0]) hull() {
    translate([0, py, pz - (slot_l - slot_w) / 2]) cylinder(h = plate_t + 1, d = slot_w);
    translate([0, py, pz + (slot_l - slot_w) / 2]) cylinder(h = plate_t + 1, d = slot_w);
  }
}

difference() {
  union() {
    /* horizontal leg */
    cube([horiz_len, profile_w, plate_t]);
    /* vertical leg, overlapping the corner block */
    cube([plate_t, profile_w, vert_len]);
  }
  euro_slot_z(13.2, 16);
  euro_slot_x(13.2, 16);
  euro_slot_z(66.8, 16);
}
