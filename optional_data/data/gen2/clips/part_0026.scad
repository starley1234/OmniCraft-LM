$fn = 32;

// ----------------------------------------------------------------------
// Cable clip: cable 4 mm, clamp 8 mm, base 28 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
foot_w = 28;              // base length, X
foot_d = 16;              // base width, Y
foot_t = 6;               // base thickness
hose_seat_d = 8;          // clamp outside diameter
ring_t = 2;               // clamp wall
cable_d = 4;              // cable opening
ring_w = 8;               // clamp width along the cable
screw_d = 5.5;            // screw clearance
sink = 1;                 // overlap of the clamp into the base

module base() {
  cube([foot_w, foot_d, foot_t]);
}

module clamp() {
  translate([foot_w / 2, foot_d / 2, foot_t + hose_seat_d / 2 - sink]) rotate([0, 90, 0])
    cylinder(h = ring_w, d = hose_seat_d, center = true);
}

difference() {
  union() {
    base();
    clamp();
  }
  translate([foot_w / 2, foot_d / 2, foot_t + hose_seat_d / 2 - sink]) rotate([0, 90, 0]) translate([0, 0, -ring_w / 2 - 1]) cylinder(h = ring_w + 2, d = cable_d);
  translate([7, foot_d / 2, -1]) cylinder(h = foot_t + 2, d = screw_d);
  translate([21, foot_d / 2, -1]) cylinder(h = foot_t + 2, d = screw_d);
}
