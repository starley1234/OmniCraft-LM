$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 100 x 40 x 45 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
horiz_len = 100;          // horizontal leg, X
vert_len = 45;            // vertical leg, Z
profile_w = 40;           // bracket depth, Y
plate_t = 6;              // plate thickness
hole_d = 3.4;             // clearance for M3
slot_w = 5.5;             // euro screw slot width
slot_l = 13;              // euro screw slot length
rib_leg = 22.9;           // gusset leg
rib_sink = 1.6;           // gusset overlap into the plates

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = plate_t + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = plate_t + 5, d = hole_d);
}
module euro_slot_z(px, py) {
  hull() {
    translate([px - (slot_l - slot_w) / 2, py, -2.5]) cylinder(h = plate_t + 5, d = slot_w);
    translate([px + (slot_l - slot_w) / 2, py, -2.5]) cylinder(h = plate_t + 5, d = slot_w);
  }
}
module euro_slot_x(pz, py) {
  translate([-2.5, 0, 0]) rotate([0, 90, 0]) hull() {
    translate([0, py, pz - (slot_l - slot_w) / 2]) cylinder(h = plate_t + 5, d = slot_w);
    translate([0, py, pz + (slot_l - slot_w) / 2]) cylinder(h = plate_t + 5, d = slot_w);
  }
}
module gusset() {
  translate([0, profile_w - rib_sink, 0])
    rotate([90, 0, 0])
      linear_extrude(height = profile_w - 2 * rib_sink)
        polygon(points = [[rib_sink, rib_sink], [rib_leg, rib_sink], [rib_sink, rib_leg]]);
}

difference() {
  union() {
    /* horizontal leg */
    cube([horiz_len, profile_w, plate_t]);
    /* vertical leg, overlapping the corner block */
    cube([plate_t, profile_w, vert_len]);
    gusset();
  }
  euro_slot_z(10, 20);
  euro_slot_x(10, 20);
  euro_slot_z(90, 20);
}
