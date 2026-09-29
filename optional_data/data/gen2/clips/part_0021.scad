$fn = 32;

// ----------------------------------------------------------------------
// Cable clip: cable 4 mm, clamp 12 mm, base 36 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_w = 36;              // base length, X
base_d = 20;              // base width, Y
base_t = 6;               // base thickness
clamp_d = 12;             // clamp outside diameter
wall_t = 4;               // clamp wall
cable_d = 4;              // cable opening
ring_w = 6;               // clamp width along the cable
screw_d = 3.4;            // screw clearance
sink = 1;                 // overlap of the clamp into the base
pitch = 18;               // distance between the two clamps

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
  translate([9, base_d / 2, -1]) cylinder(h = base_t + 2, d = screw_d);
  translate([27, base_d / 2, -1]) cylinder(h = base_t + 2, d = screw_d);
}
