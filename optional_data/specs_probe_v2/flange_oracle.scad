$fn = 32;
// ----------------------------------------------------------------------
// Flange: 96 x 96 x 10 mm
// ----------------------------------------------------------------------
// --- parameters (mm) ---
outer_d = 96;             // outer diameter
body_t = 10;              // flange thickness
hole_a = 4.5;             // clearance for M4
hole_b = 12;              // clearance for M8
slot_w = 5.5;             // adjustment slot width
slot_l = 16;              // adjustment slot length
module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = body_t + 5, d = hole_zap);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = body_t + 5, d = hole_x_zap);
}
module base() {
  cylinder(h = body_t, d = outer_d);
}
module flange() {
  translate([0, outer_d / 2 - 1, body_t])
    cylinder(h = body_t + 1, d = outer_d);
}
module adjustment_slot() {
  hull() {
    translate([outer_d / 2 - (slot_l - slot_w) / 2, -outer_d / 2 - 1, body_t])
      cube([slot_l - slot_w, outer_d + 2, body_t + 1]);
    translate([outer_d / 2 - (slot_l - slot_w) / 2, outer_d / 2 + 1, body_t])
      cube([slot_l - slot_w, -outer_d / 2 - 1, body_t + 1]);
  }
}
difference() {
  union() {
    base();
    flange();
  }
  adjustment_slot(18, 18, 10);
  hole_z(18, 18);
  hole_x(16, 18);
}
