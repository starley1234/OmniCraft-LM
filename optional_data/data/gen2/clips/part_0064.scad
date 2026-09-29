$fn = 32;

// ----------------------------------------------------------------------
// Cable clip: cable 16 mm, clamp 20 mm, base 40 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
foot_w = 40;              // base length, X
foot_d = 28;              // base width, Y
foot_t = 4;               // base thickness
hose_seat_d = 20;         // clamp outside diameter
ring_t = 2;               // clamp wall
cable_d = 16;             // cable opening
ring_w = 8;               // clamp width along the cable
screw_d = 3.4;            // screw clearance
throat = 12.48;           // snap throat width
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
  /* snap throat: the opening is narrower than the cable */
  translate([foot_w / 2 - throat / 2, foot_d / 2, foot_t + hose_seat_d / 2 - sink]) rotate([0, 90, 0]) translate([0, 0, -ring_w / 2 - 1]) cube([throat, hose_seat_d + 2, ring_w + 2]);
  translate([10, foot_d / 2, -1]) cylinder(h = foot_t + 2, d = screw_d);
  translate([30, foot_d / 2, -1]) cylinder(h = foot_t + 2, d = screw_d);
}
