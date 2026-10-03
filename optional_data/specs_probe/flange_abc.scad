$fn = 32;
// ----------------------------------------------------------------------
// Freeform cube: 96 x 96 x 10
// ----------------------------------------------------------------------
// --- parameters (mm) ---
base_len = 96;            // base length, X
base_w = 96;              // base width, Y
base_h = 10;              // base height, Z
top_len = 32;             // top length, X
top_w = 32;               // top width, Y
top_h = 6;                // top height, Z
hole_d = 4.5;             // clearance for M4
slot_w = 5.5;             // adjustment slot width
slot_l = 13;              // adjustment slot length
rib_leg = 18;             // gusset leg
rib_sink = 1.6;           // gusset overlap into the base
module base() {
  cube([base_len, base_w, base_h]);
}
module top() {
  translate([base_len / 2, base_w / 2, base_h - 1])
    cube([top_len, top_w, top_h]);
}
module gusset() {
  translate([0, base_w / 2 - rib_sink, base_h - rib_sink])
    rotate([90, 0, 0])
      linear_extrude(height = base_w / 2 - rib_sink)
        polygon(points = [[rib_sink, rib_sink], [rib_leg, rib_sink], [rib_sink, rib_leg]]);
}
module adjustment_slots() {
  for (i = [0:3]) {
    translate([base_len * i / 4, -slot_w / 2, base_h - 1])
      linear_extrude(height = slot_w + 1)
        polygon(points = [[-slot_l / 2, 0], [slot_l / 2, 0], [-slot_l / 2, slot_w]]);
  }
}
difference() {
  union() {
    base();
    top();
    gusset();
  }
  adjustment_slots();
  for (i = [0:3]) translate([base_len * i / 4, -slot_w / 2 - 1, base_h - 1])
    cylinder(h = base_h - 1, d = slot_w + 2);
}
