$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 55 x 50 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
span = 55;                // outer length, X
outer_w = 50;             // outer width, Y
wall_h = 50;              // upright height, Z
plate_t = 3;              // wall thickness
hole_d = 3.4;             // clearance for M3
window_l = 24.8;          // window length
window_h = 15.5;          // window height

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
  hole_z(6.8, 25);
  hole_z(48.2, 25);
  /* lightening window through both uprights */
  translate([span / 2 - window_l / 2, -1, plate_t + 4])
    cube([window_l, outer_w + 2, window_h]);
}
