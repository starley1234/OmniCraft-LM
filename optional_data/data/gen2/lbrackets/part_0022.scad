$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 30 x 16 x 35 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
horiz_len = 30;           // horizontal leg, X
vert_len = 35;            // vertical leg, Z
profile_w = 16;           // bracket depth, Y
plate_t = 3;              // plate thickness
hole_d = 5.5;             // clearance for M5
slot_l = 24;              // adjustment slot length

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = plate_t + 1, d = hole_d);
}
module hole_x(pz, py) {
  translate([-0.5, py, pz]) rotate([0, 90, 0]) cylinder(h = plate_t + 1, d = hole_d);
}
module adjust_slot(px, py) {
  hull() {
    translate([px - (slot_l - hole_d) / 2, py, -0.5]) cylinder(h = plate_t + 1, d = hole_d);
    translate([px + (slot_l - hole_d) / 2, py, -0.5]) cylinder(h = plate_t + 1, d = hole_d);
  }
}

difference() {
  union() {
    /* horizontal leg */
    cube([horiz_len, profile_w, plate_t]);
    /* vertical leg, overlapping the corner block */
    cube([plate_t, profile_w, vert_len]);
  }
  adjust_slot(15, 8);
  hole_x(17.5, 8);
}
