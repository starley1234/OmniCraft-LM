$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 40 x 40 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
span = 40;                // outer length, X
outer_w = 40;             // outer width, Y
wall_h = 60;              // upright height, Z
plate_t = 4;              // wall thickness
hole_d = 6.6;             // clearance for M6
window_l = 18.8;          // window length
window_h = 25.8;          // window height

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = plate_t + 5, d = hole_d);
}
module hole_y_pz(pz) {
  /* through both uprights along Y */
  translate([0, -2.5, pz]) rotate([-90, 0, 0]) cylinder(h = outer_w + 5, d = hole_d);
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
  hole_z(20, 20);
  /* lightening window through both uprights */
  translate([span / 2 - window_l / 2, -1, plate_t + 4])
    cube([window_l, outer_w + 2, window_h]);
}
