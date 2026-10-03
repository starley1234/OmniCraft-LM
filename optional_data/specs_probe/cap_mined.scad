$fn = 32;
// ----------------------------------------------------------------------
// Freeform cube: 100 x 100 x 100 mm, 10 mm thick
// ----------------------------------------------------------------------
// --- parameters (mm) ---
base_len = 100;           // base length
base_w = 100;             // base width
base_h = 100;             // base height
plate_t = 3;              // plate thickness
hole_d = 6.6;             // clearance for M6
slot_w = 1.6;             // adjustment slot width
slot_l = 19;              // adjustment slot length
rib_leg = 45.8;           // gusset leg
rib_sink = 1.9;           // gusset overlap into the plates
module base_extrude() {
  cube([base_len, base_w, plate_t]);
}
module gusset() {
  translate([0, base_w / 2 - rib_sink, plate_t])
    rotate([90, 0, 0])
      linear_extrude(height = base_w / 2 - rib_sink)
        polygon(points = [[rib_sink, rib_sink], [rib_leg, rib_sink], [rib_sink, rib_leg]]);
}
module adjustment_slots() {
  translate([-base_len / 2 - slot_l / 2, 0, plate_t - slot_w])
    linear_extrude(height = base_h - plate_t + slot_w)
      polygon(points = [[slot_l / 2, -slot_w / 2], [slot_l / 2, slot_w / 2], [-slot_l / 2, -slot_w / 2]]);
}
module gusset_adjustment() {
  translate([0, base_w / 2 - rib_sink, plate_t])
    rotate([90, 0, 0])
      linear_extrude(height = base_w / 2 - plate_t + rib_sink)
        polygon(points = [[rib_sink, rib_sink], [rib_leg, rib_sink], [rib_sink, -rib_leg]]);
}
difference() {
  union() {
    base_extrude();
    gusset();
    adjustment_slots();
    gusset_adjustment();
  }
}
