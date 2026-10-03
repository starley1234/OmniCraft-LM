$fn = 32;
// ----------------------------------------------------------------------
// Freeform cube: 100 x 100 x 100
// ----------------------------------------------------------------------
// --- parameters (mm) ---
base_len = 100;           // base edge, X and Y
base_w = 100;             // base width, Y
base_h = 100;             // base height, Z
top_len = 50;             // top edge, X
top_w = 50;               // top width, Y
top_h = 25;               // top height, Z
hole_d = 4.5;             // clearance for M4
slot_w = 5;               // adjustment slot width
slot_l = 16;              // adjustment slot length
module base_box() {
  cube([base_len, base_w, base_h]);
}
module top_box() {
  translate([0, 0, base_h - 1]) cube([top_len, base_w, top_h]);
}
module adjustment_slot() {
  /* Slot through both base and top boxes, adjusted for the gap in the middle */
  translate([base_len / 2 - (slot_l / 2 - (top_len / 2 - slot_l / 2)) / 2, 0, -1])
    cube([slot_l - 1, base_w, top_h + 1]);
}
difference() {
  union() {
    base_box();
    top_box();
  }
  adjustment_slot();
  for (i = [0:5]) rotate([0, 90, 0]) translate([25.4 * i - 13.2, 0, -1]) cylinder(h = base_h + 2, d = hole_d);
}
