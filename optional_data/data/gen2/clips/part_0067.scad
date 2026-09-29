$fn = 32;

// ----------------------------------------------------------------------
// Cable clip: cable 5 mm, clamp 9 mm, base 21 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
foot_w = 21;              // base length, X
foot_d = 13;              // base width, Y
foot_t = 3;               // base thickness
hose_seat_d = 9;          // clamp outside diameter
ring_t = 2;               // clamp wall
cable_d = 5;              // cable opening
ring_w = 10;              // clamp width along the cable
screw_d = 4.5;            // screw clearance
throat = 3.5;             // snap throat width
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
  translate([10.5, foot_d / 2, -1]) cylinder(h = foot_t + 2, d = screw_d);
}
