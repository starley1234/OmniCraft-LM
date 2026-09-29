$fn = 32;

// ----------------------------------------------------------------------
// Handle: 80 x 26 mm grip, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 80;              // grip length
width = 26;               // grip width
thickness = 12;           // grip thickness
waist = 0.72;             // width factor at the middle
draft = 0.94;             // top face scale of the extrusion
scallops = 6;             // finger rests per side
ripple = 0.06;            // depth factor of the finger rests
boss_d = 27.3;            // mounting boss diameter
boss_h = 10;              // mounting boss height
boss_hole_d = 11.47;      // screw clearance through the boss
boss_r = 24.35;           // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-27, 13], [-23.625, 12.026], [-20.25, 11.407], [-16.875, 11.061], [-13.5, 9.808], [-10.125, 10.232], [-6.75, 9.588], [-3.375, 9.024], [0, 9.922], [3.375, 9.024], [6.75, 9.588], [10.125, 10.232], [13.5, 9.808], [16.875, 11.061], [20.25, 11.407], [23.625, 12.026], [27, 13], [33.5, 11.258], [38.258, 6.5], [40, 0], [38.258, -6.5], [33.5, -11.258], [27, -13], [27, -13], [23.625, -12.026], [20.25, -11.407], [16.875, -11.061], [13.5, -9.808], [10.125, -10.232], [6.75, -9.588], [3.375, -9.024], [0, -9.922], [-3.375, -9.024], [-6.75, -9.588], [-10.125, -10.232], [-13.5, -9.808], [-16.875, -11.061], [-20.25, -11.407], [-23.625, -12.026], [-27, -13], [-33.5, -11.258], [-38.258, -6.5], [-40, 0], [-38.258, 6.5], [-33.5, 11.258], [-27, 13]];

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
