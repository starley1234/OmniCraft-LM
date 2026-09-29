$fn = 32;

// ----------------------------------------------------------------------
// Handle: 80 x 26 mm grip, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 80;              // grip length
width = 26;               // grip width
thickness = 10;           // grip thickness
waist = 0.72;             // width factor at the middle
draft = 0.94;             // top face scale of the extrusion
scallops = 5;             // finger rests per side
ripple = 0.05;            // depth factor of the finger rests
boss_d = 27.3;            // mounting boss diameter
boss_h = 8;               // mounting boss height
boss_hole_d = 11.47;      // screw clearance through the boss
boss_r = 24.35;           // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-27, 13], [-23.625, 12.201], [-20.25, 11.584], [-16.875, 10.478], [-13.5, 10.27], [-10.125, 10.264], [-6.75, 9.27], [-3.375, 9.24], [0, 9.828], [3.375, 9.24], [6.75, 9.27], [10.125, 10.264], [13.5, 10.27], [16.875, 10.478], [20.25, 11.584], [23.625, 12.201], [27, 13], [33.5, 11.258], [38.258, 6.5], [40, 0], [38.258, -6.5], [33.5, -11.258], [27, -13], [27, -13], [23.625, -12.201], [20.25, -11.584], [16.875, -10.478], [13.5, -10.27], [10.125, -10.264], [6.75, -9.27], [3.375, -9.24], [0, -9.828], [-3.375, -9.24], [-6.75, -9.27], [-10.125, -10.264], [-13.5, -10.27], [-16.875, -10.478], [-20.25, -11.584], [-23.625, -12.201], [-27, -13], [-33.5, -11.258], [-38.258, -6.5], [-40, 0], [-38.258, 6.5], [-33.5, 11.258], [-27, 13]];

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
