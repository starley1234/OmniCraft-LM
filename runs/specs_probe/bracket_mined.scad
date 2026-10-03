$fn = 32;
// ----------------------------------------------------------------------
// Freeform bracket: 100 x 100 x 100 mm
// ----------------------------------------------------------------------
// --- parameters (mm) ---
base_len = 100;           // outer length, X
upright_h = 100;          // upright height, Z
flange_w = 100;           // outer width, Y
flange_t = 4;             // flange thickness
mat_t = 3;                // tube thickness
hole_d = 5.5;             // clearance for M5
slot_w = 5.5;             // euro screw slot width
slot_l = 13;              // euro screw slot length
rib_leg = 45;             // gusset leg
rib_sink = 1.6;           // gusset overlap into the uprights
module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = flange_t + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = flange_t + 5, d = hole_d);
}
module euro_slot_z(px, py) {
  hull() {
    translate([px - (slot_l - slot_w) / 2, py, -2.5]) cylinder(h = flange_t + 5, d = slot_w);
    translate([px + (slot_l - slot_w) / 2, py, -2.5]) cylinder(h = flange_t + 5, d = slot_w);
  }
}
module euro_slot_x(pz, py) {
  translate([-2.5, 0, 0]) rotate([0, 90, 0]) hull() {
    translate([0, py, pz - (slot_l - slot_w) / 2]) cylinder(h = flange_t + 5, d = slot_w);
    translate([0, py, pz + (slot_l - slot_w) / 2]) cylinder(h = flange_t + 5, d = slot_w);
  }
}
module gusset() {
  translate([0, flange_w - rib_sink, 0])
    rotate([90, 0, 0])
      linear_extrude(height = flange_w - 2 * rib_sink)
        polygon(points = [[rib_sink, rib_sink], [rib_leg, rib_sink], [rib_sink, rib_leg]]);
}
module base() {
  cube([base_len, flange_w, flange_t]);
}
module uprights() {
  cube([base_len, flange_w, upright_h]);
  translate([0, flange_w - 1, 0]) cube([base_len, flange_w - 1, upright_h]);
}
module gusset_hull() {
  translate([0, flange_w - 1, 0])
    cube([base_len, flange_w - 1, upright_h - 1]);
}
difference() {
  union() {
    base();
    uprights();
    gusset();
  }
  euro_slot_z(10, 50);
  euro_slot_x(13, 50);
}
