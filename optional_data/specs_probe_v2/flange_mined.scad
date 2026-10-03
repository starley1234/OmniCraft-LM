$fn = 32;
// ----------------------------------------------------------------------
// Flange: 96 x 96 x 10 mm
// ----------------------------------------------------------------------
// --- parameters (mm) ---
outer_d = 96;             // outer diameter
wall = 5;                 // wall thickness
flange_t = 10;            // flange thickness
hub_d = 32;               // hub diameter
hub_len = 18;             // hub length
bolt_d = 4.5;             // bolt hole diameter
bolt_n = 16;              // number of bolt holes
module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = flange_t + 5, d = bolt_d);
}
module hole_y_pz(pz) {
  /* through both flanges along the y axis */
  translate([0, -2.5, pz]) rotate([-90, 0, 0]) cylinder(h = flange_t + 5, d = bolt_d);
}
module base() {
  cylinder(h = flange_t, d = outer_d);
}
module hub() {
  translate([0, outer_d / 2 - 1, 0])
    cylinder(h = flange_t + 1, d = hub_d);
}
module flange() {
  /* flange with a hub sunk into it */
  translate([0, flange_t / 2 - 1, -2.5])
    cube([outer_d, outer_d, flange_t + 5]);
}
difference() {
  union() {
    base();
    hub();
    flange();
  }
  /* through bolts */
  for (i = [0:bolt_n - 1])
    hole_z((outer_d - bolt_d) / 2 + i * (bolt_d - 2.5) / 16, 0);
  for (i = [0:hub_len - 1])
    hole_y_pz((hub_len - 1) / 2 + i * 0.5);
}
