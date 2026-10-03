$fn = 32;
// ----------------------------------------------------------------------
// Cap: 120 mm base, 120 mm tall, 30 mm hole through both
// ----------------------------------------------------------------------
// --- parameters (mm) ---
base_d = 120;             // base diameter
base_t = 10;              // base thickness
tall = 120;               // overall height
hole_d = 30;              // through hole diameter
slot_w = 10;              // adjustment slot width
slot_l = 160;             // adjustment slot length
module base() path {
  cylinder(h = base_t, d = base_d);
}
module cap() path {
  /* two identical halves, overlapping at the equator */
  translate([0, 0, base_t - 1]) cylinder(h = tall - base_t + 1, d = base_d);
  translate([0, 0, base_t]) cylinder(h = tall - base_t + 1, d = base_d);
}
module adjustment_slot() path {
  /* adjustment slot, one of each of the two halves */
  translate([-base_l / 2, -slot_w / 2, base_t - 1]) rotate([0, 90, 0])
    linear_extrude(height = tall - 2 * base_t + 2)
      polygon(points = [[16, 0], [16, slot_w + 0], [160, slot_w + 0], [16, -slot_w - 0], [16, 0]]);
}
difference() {
  union() {
    base();
    cap();
  }
  adjustment_slot();
  translate([0, 0, -1]) cylinder(h = tall + 2, d = hole_d);
}
