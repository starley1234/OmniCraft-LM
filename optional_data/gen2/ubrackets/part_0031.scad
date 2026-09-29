$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 60 x 70 x 30 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 60;              // outer length, X
width = 70;               // outer width, Y
height = 30;              // upright height, Z
thick = 8;                // wall thickness
hole_d = 6.6;             // clearance for M6
cb_d = 11;                // counterbore diameter
cb_h = 3.4;               // counterbore depth

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = thick + 1, d = hole_d);
}
module hole_y_pz(pz) {
  /* through both uprights along Y */
  translate([0, -0.5, pz]) rotate([-90, 0, 0]) cylinder(h = width + 1, d = hole_d);
}
module cb_z(px, py) {
  translate([px, py, thick - cb_h]) cylinder(h = cb_h + 0.4, d = cb_d);
}

module base() {
  cube([length, width, thick]);
}

module uprights() {
  cube([length, thick, height]);
  translate([0, width - thick, 0]) cube([length, thick, height]);
}

difference() {
  union() {
    base();
    uprights();
  }
  hole_z(13.2, 35);
  cb_z(13.2, 35);
  hole_z(46.8, 35);
  cb_z(46.8, 35);
}
