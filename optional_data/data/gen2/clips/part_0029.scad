$fn = 32;

// ----------------------------------------------------------------------
// Cable clip: cable 8 mm, clamp 16 mm, base 28 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
base_w = 28;              // base length, X
base_d = 22;              // base width, Y
base_t = 4;               // base thickness
clamp_d = 16;             // clamp outside diameter
wall_t = 4;               // clamp wall
cable_d = 8;              // cable opening
ring_w = 6;               // clamp width along the cable
screw_d = 3.4;            // screw clearance
throat = 6.24;            // snap throat width
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
  /* snap throat: the opening is narrower than the cable */
  translate([base_w / 2 - throat / 2, base_d / 2, base_t + clamp_d / 2 - sink]) rotate([0, 90, 0]) translate([0, 0, -ring_w / 2 - 1]) cube([throat, clamp_d + 2, ring_w + 2]);
  translate([14, base_d / 2, -1]) cylinder(h = base_t + 2, d = screw_d);
}
