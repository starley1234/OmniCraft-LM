$fn = 32;

// ----------------------------------------------------------------------
// Cable clip: cable 6 mm, clamp 11 mm, base 34 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
foot_w = 34;              // base length, X
foot_d = 15;              // base width, Y
foot_t = 4;               // base thickness
hose_seat_d = 11;         // clamp outside diameter
ring_t = 2.5;             // clamp wall
cable_d = 6;              // cable opening
ring_w = 12;              // clamp width along the cable
screw_d = 3.4;            // screw clearance
sink = 1;                 // overlap of the clamp into the base
pitch = 17;               // distance between the two clamps

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
  translate([8.5, foot_d / 2, -1]) cylinder(h = foot_t + 2, d = screw_d);
  translate([25.5, foot_d / 2, -1]) cylinder(h = foot_t + 2, d = screw_d);
}
