$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 90 x 35 x 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
span = 90;                // outer length, X
outer_w = 35;             // outer width, Y
wall_h = 25;              // upright height, Z
plate_t = 3;              // wall thickness
hole_d = 5.5;             // clearance for M5
window_l = 34.2;          // window length
window_h = 8.8;           // window height

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
  hole_z(11, 17.5);
  hole_z(79, 17.5);
  /* lightening window through both uprights */
  translate([span / 2 - window_l / 2, -1, plate_t + 4])
    cube([window_l, outer_w + 2, window_h]);
}
