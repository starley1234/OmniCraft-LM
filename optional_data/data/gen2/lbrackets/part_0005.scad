$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 30 x 16 x 55 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
horiz_len = 30;           // horizontal leg, X
vert_len = 55;            // vertical leg, Z
profile_w = 16;           // bracket depth, Y
plate_t = 6;              // plate thickness
hole_d = 5.5;             // clearance for M5
cb_d = 9.5;               // counterbore seat
cb_h = 2.9;               // counterbore depth

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = plate_t + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = plate_t + 5, d = hole_d);
}
module cb_z(px, py) {
  translate([px, py, plate_t - cb_h]) cylinder(h = cb_h + 0.4, d = cb_d);
}
module cb_x(pz, py) {
  translate([plate_t - cb_h, py, pz]) rotate([0, -90, 0]) cylinder(h = cb_h + 0.4, d = cb_d);
}

difference() {
  union() {
    /* horizontal leg */
    cube([horiz_len, profile_w, plate_t]);
    /* vertical leg, overlapping the corner block */
    cube([plate_t, profile_w, vert_len]);
  }
  hole_z(15, 8);
  cb_z(15, 8);
  hole_x(11, 8);
  cb_x(11, 8);
  hole_x(44, 8);
  cb_x(44, 8);
}
