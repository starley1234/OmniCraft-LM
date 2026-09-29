$fn = 32;

// ----------------------------------------------------------------------
// Cable clip: cable 16 mm, clamp 22 mm, base 56 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_w = 56;              // base length, X
base_d = 30;              // base width, Y
base_t = 3;               // base thickness
clamp_d = 22;             // clamp outside diameter
wall_t = 3;               // clamp wall
cable_d = 16;             // cable opening
ring_w = 10;              // clamp width along the cable
screw_d = 4.5;            // screw clearance
sink = 1;                 // overlap of the clamp into the base
pitch = 28;               // distance between the two clamps

module base() {
  cube([base_w, base_d, base_t]);
}

module clamps() {
  for (sx = [-1, 1])
    translate([base_w / 2 + sx * pitch / 2, base_d / 2, base_t + clamp_d / 2 - sink]) rotate([0, 90, 0])
      cylinder(h = ring_w, d = clamp_d, center = true);
}

difference() {
  union() {
    base();
    clamps();
  }
  for (sx = [-1, 1])
    translate([base_w / 2 + sx * pitch / 2, base_d / 2, base_t + clamp_d / 2 - sink]) rotate([0, 90, 0]) translate([0, 0, -ring_w / 2 - 1]) cylinder(h = ring_w + 2, d = cable_d);
  translate([14, base_d / 2, -1]) cylinder(h = base_t + 2, d = screw_d);
  translate([42, base_d / 2, -1]) cylinder(h = base_t + 2, d = screw_d);
}
