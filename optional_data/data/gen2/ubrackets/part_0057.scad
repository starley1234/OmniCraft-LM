$fn = 32;

// ----------------------------------------------------------------------
// U-bracket: 55 x 35 x 50 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
span = 55;                // outer length, X
outer_w = 35;             // outer width, Y
wall_h = 50;              // upright height, Z
plate_t = 4;              // wall thickness
hole_d = 6.6;             // clearance for M6
slot_l = 20;              // slot length

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = plate_t + 5, d = hole_d);
}
module hole_y_pz(pz) {
  /* through both uprights along Y */
  translate([0, -2.5, pz]) rotate([-90, 0, 0]) cylinder(h = outer_w + 5, d = hole_d);
}
module slot_z(px, py) {
  hull() {
    translate([px - (slot_l - hole_d) / 2, py, -2.5]) cylinder(h = plate_t + 5, d = hole_d);
    translate([px + (slot_l - hole_d) / 2, py, -2.5]) cylinder(h = plate_t + 5, d = hole_d);
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
  slot_z(27.5, 17.5);
}
