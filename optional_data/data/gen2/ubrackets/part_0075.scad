$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 40 x 70 x 60 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
span = 40;                // outer length, X
outer_w = 70;             // outer width, Y
wall_h = 60;              // upright height, Z
plate_t = 3;              // wall thickness
hole_d = 9;               // clearance for M8
slot_l = 14;              // slot length

module hole_z(px, py) {
  translate([px, py, -0.5]) cylinder(h = plate_t + 1, d = hole_d);
}
module hole_y_pz(pz) {
  /* through both uprights along Y */
  translate([0, -0.5, pz]) rotate([-90, 0, 0]) cylinder(h = outer_w + 1, d = hole_d);
}
module slot_z(px, py) {
  hull() {
    translate([px - (slot_l - hole_d) / 2, py, -0.5]) cylinder(h = plate_t + 1, d = hole_d);
    translate([px + (slot_l - hole_d) / 2, py, -0.5]) cylinder(h = plate_t + 1, d = hole_d);
  }
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
  slot_z(20, 35);
}
