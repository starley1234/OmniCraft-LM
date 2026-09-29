$fn = 32;

// ----------------------------------------------------------------------
// Cable clip: cable 12 mm, clamp 20 mm, base 52 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
foot_w = 52;              // base length, X
foot_d = 28;              // base width, Y
foot_t = 3;               // base thickness
hose_seat_d = 20;         // clamp outside diameter
ring_t = 4;               // clamp wall
cable_d = 12;             // cable opening
ring_w = 12;              // clamp width along the cable
screw_d = 5.5;            // screw clearance
sink = 1;                 // overlap of the clamp into the base
pitch = 26;               // distance between the two clamps

module base() {
  cube([foot_w, foot_d, foot_t]);
}

module clamps() {
  for (sx = [-1, 1])
    translate([foot_w / 2 + sx * pitch / 2, foot_d / 2, foot_t + hose_seat_d / 2 - sink]) rotate([0, 90, 0])
      cylinder(h = ring_w, d = hose_seat_d, center = true);
}

difference() {
  union() {
    base();
    clamps();
  }
  for (sx = [-1, 1])
    translate([foot_w / 2 + sx * pitch / 2, foot_d / 2, foot_t + hose_seat_d / 2 - sink]) rotate([0, 90, 0]) translate([0, 0, -ring_w / 2 - 1]) cylinder(h = ring_w + 2, d = cable_d);
  translate([13, foot_d / 2, -1]) cylinder(h = foot_t + 2, d = screw_d);
  translate([39, foot_d / 2, -1]) cylinder(h = foot_t + 2, d = screw_d);
}
