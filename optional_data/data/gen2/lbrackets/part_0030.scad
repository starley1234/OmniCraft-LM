$fn = 32;

// ----------------------------------------------------------------------
// L-bracket: 80 x 40 x 80 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
run_out = 80;             // horizontal leg, X
rise = 80;                // vertical leg, Z
bracket_w = 40;           // bracket depth, Y
sheet_t = 3;              // plate thickness
hole_d = 3.4;             // clearance for M3
slot_w = 5.5;             // euro screw slot width
slot_l = 13;              // euro screw slot length

module hole_z(px, py) {
  translate([px, py, -2.5]) cylinder(h = sheet_t + 5, d = hole_d);
}
module hole_x(pz, py) {
  translate([-2.5, py, pz]) rotate([0, 90, 0]) cylinder(h = sheet_t + 5, d = hole_d);
}
module euro_slot_z(px, py) {
  hull() {
    translate([px - (slot_l - slot_w) / 2, py, -2.5]) cylinder(h = sheet_t + 5, d = slot_w);
    translate([px + (slot_l - slot_w) / 2, py, -2.5]) cylinder(h = sheet_t + 5, d = slot_w);
  }
}
module euro_slot_x(pz, py) {
  translate([-2.5, 0, 0]) rotate([0, 90, 0]) hull() {
    translate([0, py, pz - (slot_l - slot_w) / 2]) cylinder(h = sheet_t + 5, d = slot_w);
    translate([0, py, pz + (slot_l - slot_w) / 2]) cylinder(h = sheet_t + 5, d = slot_w);
  }
}

difference() {
  union() {
    /* horizontal leg */
    cube([run_out, bracket_w, sheet_t]);
    /* vertical leg, overlapping the corner block */
    cube([sheet_t, bracket_w, rise]);
  }
  euro_slot_z(10, 20);
  euro_slot_x(10, 20);
  euro_slot_z(70, 20);
}
