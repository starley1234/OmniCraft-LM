$fn = 32;
// ----------------------------------------------------------------------
// L-bracket: 100 x 100 x 100 mm
// ----------------------------------------------------------------------
// --- parameters (mm) ---
base_len = 100;            // horizontal leg, X
upright_h = 100;            // vertical leg, Z
flange_w = 100;             // bracket depth, Y
mat_t = 3;                  // plate thickness
hole_d = 4.5;               // clearance for M4
slot_w = 5.5;               // euro screw slot width
slot_l = 13;                // euro screw slot length
rib_leg = 55.5;             // gusset leg
rib_sink = 1.6;             // gusset overlap into the plates
module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = mat_t + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = mat_t + 5, d = hole_d);
}
module euro_slot_z(px, py) {
  hull() {
    translate([px - (slot_l - slot_w) / 2, py, -2.5]) cylinder(h = mat_t + 5, d = slot_w);
    translate([px + (slot_l - slot_w) / 2, py, -2.5]) cylinder(h = mat_t + 5, d = slot_w);
  }
}
module euro_slot_x(pz, py) {
  translate([-2.5, 0, 0]) rotate([0, 90, 0]) hull() {
    translate([0, py, pz - (slot_l - slot_w) / 2]) cylinder(h = mat_t + 5, d = slot_w);
    translate([0, py, pz + (slot_l - slot_w) / 2]) cylinder(h = mat_t + 5, d = slot_w);
  }
}
module gusset() {
  translate([0, flange_w - rib_sink, 0])
    rotate([90, 0, 0])
      linear_extrude(height = flange_w - 2 * rib_sink)
        polygon(points = [[rib_sink, rib_sink], [rib_leg, rib_sink], [rib_sink, rib_leg]]);
}
difference() {
  union() {
    /* horizontal leg */
    cube([base_len, flange_w, mat_t]);
    /* vertical leg, overlapping the corner block */
    cube([mat_t, flange_w, upright_h]);
    gusset();
  }
  euro_slot_z(10, 50);
  euro_slot_x(10, 50);
}
