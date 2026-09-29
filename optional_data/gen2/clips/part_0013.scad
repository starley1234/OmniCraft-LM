$fn = 32;

// ----------------------------------------------------------------------
// Cable clip: cable 5 mm, clamp 13 mm, base 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_w = 25;              // base length, X
base_d = 17;              // base width, Y
base_t = 6;               // base thickness
clamp_d = 13;             // clamp outside diameter
wall_t = 4;               // clamp wall
cable_d = 5;              // cable opening
ring_w = 12;              // clamp width along the cable
screw_d = 3.4;            // screw clearance
sink = 1;                 // overlap of the clamp into the base

module base() {
  cube([base_w, base_d, base_t]);
}

module clamp() {
  translate([base_w / 2, base_d / 2, base_t + clamp_d / 2 - sink]) rotate([0, 90, 0])
    cylinder(h = ring_w, d = clamp_d, center = true);
}

difference() {
  union() {
    base();
    clamp();
  }
  translate([base_w / 2, base_d / 2, base_t + clamp_d / 2 - sink]) rotate([0, 90, 0]) translate([0, 0, -ring_w / 2 - 1]) cylinder(h = ring_w + 2, d = cable_d);
  translate([12.5, base_d / 2, -1]) cylinder(h = base_t + 2, d = screw_d);
}
