$fn = 32;
// ----------------------------------------------------------------------
// Flange: 200 x 200 x 20 mm
// ----------------------------------------------------------------------
// --- parameters (mm) ---
flange_d = 200;           // flange outside diameter
flange_l = 200;           // flange length
flange_t = 5;             // flange thickness
hub_d = 18;               // hub diameter
hub_l = 12;               // hub length
bolt_d = 4.5;             // bolt hole diameter
bolt_n = 16;              // bolt holes per side
bolt_pitch = 16;          // bolt pitch
module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = flange_t + 5, d = bolt_d);
}
module hole_y_pz(pz) {
  /* through both flanges along the y axis, with a 2.5 mm gap in the hub */
  translate([0, -10, pz]) rotate([-90, 0, 0]) cylinder(h = flange_t + 20, d = bolt_d);
}
module base() {
  cube([flange_l, flange_d, flange_t]);
}
module flange() {
  translate([flange_l / 2, 0, flange_t - 1])
    cylinder(h = flange_t + 1, d = flange_d);
}
module hub() {
  translate([0, flange_t / 2 - 1, flange_t * 0.8])
    cylinder(h = flange_t * 0.8 + 2, d = hub_d);
}
difference() {
  union() {
    base();
    flange();
    hub();
  }
  hole_z(10, 10);
  hole_z(160, 10);
  /* through both flanges, 1.5 mm clear of the edges */
  translate([flange_l / 2 - 7.5, 0, flange_t * 0.8])
    cylinder(h = flange_t + 20, d = bolt_pitch);
}
