$fn = 32;
// ----------------------------------------------------------------------
// Chamfered mounting plate: 120 x 80 x 8 mm
// ----------------------------------------------------------------------
// --- parameters (mm) ---
base_len = 120;           // base length, X
base_w = 80;              // base width, Y
base_h = 8;               // base height, Z
upright_h = 24;           // upright leg, X
upright_d = 5;            // upright diameter
flange_t = 4;             // flange thickness
flange_d = 110;           // flange diameter
hole_d = 4.5;             // clearance for M4
slot_w = 5.5;             // adjustment slot width
slot_l = 16;              // adjustment slot length
module base() path() {
  translate([0, -base_w / 2, 0])
    cube([base_len, base_w, base_h]);
}
module upright() {
  /* chamfered upright leg, overlapping the base */
  translate([0, -base_w / 2, base_h - 1])
    cube([upright_d, base_w, upright_h - 1]);
}
module flange() {
  /* chamfered flange leg, overlapping the base */
  translate([0, base_w / 2, base_h - 1])
    rotate([-90, 0, 0])
    cylinder(h = flange_t + 1, d = flange_d);
}
difference() {
  union() {
    base();
    upright();
    flange();
  }
  /* adjustment slots on the top edge of the base */
  for (i = [0:2]) {
    translate([base_len * i / 3, -slot_w / 2, -1])
      cube([slot_l, slot_w, base_h + 2]);
  }
}
