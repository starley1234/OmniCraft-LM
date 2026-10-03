$fn = 32;
// ----------------------------------------------------------------------
// Flange: 96 x 96 x 10 mm
// ----------------------------------------------------------------------
// --- parameters (mm) ---
flange_d = 96;            // flange outside diameter
flange_l = 96;            // flange length
flange_t = 4;             // flange thickness
hub_d = 32;               // hub diameter
hub_l = 24;               // hub length
bolt_d = 4.5;             // bolt hole diameter
bolt_n = 16;              // bolt holes per side
bolt_pitch = 19;          // bolt pitch
module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = flange_t + 5, d = bolt_d);
}
module hole_y_pz(pz) {
  /* through both flanges along the y axis, with a 2.5 mm gap in the hub */
  translate([0, -2.5, pz]) rotate([-90, 0, 0]) cylinder(h = flange_t + 5, d = bolt_d);
}
module base() {
  cube([flange_l, flange_d, flange_t]);
}
module flange() {
  /* flange with a raised rim around the hub */
  translate([0, flange_t - 1.5, 0])
    cube([flange_l, flange_d, flange_t - 2.5]);
}
module hub() {
  translate([0, flange_t - 1.5, 0]) rotate([-90, 0, 0])
    cylinder(h = flange_t + 2 * (hub_l - flange_t), d = hub_d);
}
difference() {
  union() {
    base();
    flange();
    hub();
  }
  hole_z(18, 18);
  hole_z(78, 18);
  /* through both flanges along the y axis, with a 2.5 mm gap in the hub */
  translate([0, -2.5, 0]) rotate([-90, 0, 0]) cylinder(h = flange_t + 5, d = bolt_d);
}
