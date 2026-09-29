$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 110 x 45 x 30 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
span = 110;               // outer length, X
outer_w = 45;             // outer width, Y
wall_h = 30;              // upright height, Z
plate_t = 8;              // wall thickness
hole_d = 6.6;             // clearance for M6
cb_d = 11;                // counterbore diameter
cb_h = 3.4;               // counterbore depth

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = plate_t + 1, d = hole_d);
}
module hole_y_pz(pz) {
  /* through both uprights along Y */
  translate([0, -0.5, pz]) rotate([-90, 0, 0]) cylinder(h = outer_w + 1, d = hole_d);
}
module cb_z(px, py) {
  translate([px, py, plate_t - cb_h]) cylinder(h = cb_h + 0.4, d = cb_d);
}

module base() {
  cube([span, outer_w, plate_t]);
}

module uprights() {
  cube([span, plate_t, wall_h]);
  translate([0, outer_w - plate_t, 0]) cube([span, plate_t, wall_h]);
}

difference() {
  union() {
    base();
    uprights();
  }
  hole_z(13.2, 22.5);
  cb_z(13.2, 22.5);
  hole_z(96.8, 22.5);
  cb_z(96.8, 22.5);
}
