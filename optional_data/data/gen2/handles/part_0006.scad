$fn = 32;

// ----------------------------------------------------------------------
// Handle: 120 x 22 mm grip, 16 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 120;             // grip length
width = 22;               // grip width
thickness = 16;           // grip thickness
waist = 0.8;              // width factor at the middle
draft = 0.97;             // top face scale of the extrusion
scallops = 6;             // finger rests per side
ripple = 0.04;            // depth factor of the finger rests
boss_d = 23.1;            // mounting boss diameter
boss_h = 10;              // mounting boss height
boss_hole_d = 9.7;        // screw clearance through the boss
boss_r = 46.45;           // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-49, 11], [-42.875, 10.415], [-36.75, 10.037], [-30.625, 9.826], [-24.5, 9.07], [-18.375, 9.331], [-12.25, 8.938], [-6.125, 8.588], [0, 9.152], [6.125, 8.588], [12.25, 8.938], [18.375, 9.331], [24.5, 9.07], [30.625, 9.826], [36.75, 10.037], [42.875, 10.415], [49, 11], [54.5, 9.526], [58.526, 5.5], [60, 0], [58.526, -5.5], [54.5, -9.526], [49, -11], [49, -11], [42.875, -10.415], [36.75, -10.037], [30.625, -9.826], [24.5, -9.07], [18.375, -9.331], [12.25, -8.938], [6.125, -8.588], [0, -9.152], [-6.125, -8.588], [-12.25, -8.938], [-18.375, -9.331], [-24.5, -9.07], [-30.625, -9.826], [-36.75, -10.037], [-42.875, -10.415], [-49, -11], [-54.5, -9.526], [-58.526, -5.5], [-60, 0], [-58.526, 5.5], [-54.5, 9.526], [-49, 11]];

module grip_body() {
  linear_extrude(height = thickness, scale = draft) polygon(grip);
}

module boss_body() {
  /* sunk 1 mm into the grip so the joint overlaps */
  translate([boss_r, 0, thickness - 1]) cylinder(h = boss_h + 1, d = boss_d);
}

difference() {
  union() {
    grip_body();
    boss_body();
  }
  translate([boss_r, 0, -1]) cylinder(h = thickness + boss_h + 2, d = boss_hole_d);
}
