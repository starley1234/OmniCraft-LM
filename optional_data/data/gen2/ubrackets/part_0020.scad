$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 110 x 35 x 35 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
span = 110;               // outer length, X
outer_w = 35;             // outer width, Y
wall_h = 35;              // upright height, Z
plate_t = 3;              // wall thickness
hole_d = 9;               // clearance for M8
window_l = 51.7;          // window length
window_h = 15;            // window height

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = plate_t + 1, d = hole_d);
}
module hole_y_pz(pz) {
  /* through both uprights along Y */
  translate([0, -0.5, pz]) rotate([-90, 0, 0]) cylinder(h = outer_w + 1, d = hole_d);
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
  hole_z(18, 17.5);
  hole_z(92, 17.5);
  /* lightening window through both uprights */
  translate([span / 2 - window_l / 2, -1, plate_t + 4])
    cube([window_l, outer_w + 2, window_h]);
}
