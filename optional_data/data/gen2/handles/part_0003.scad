$fn = 32;

// ----------------------------------------------------------------------
// Handle: 180 x 26 mm grip, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 180;             // grip length
width = 26;               // grip width
thickness = 10;           // grip thickness
waist = 0.72;             // width factor at the middle
draft = 0.97;             // top face scale of the extrusion
boss_d = 27.3;            // mounting boss diameter
boss_h = 10;              // mounting boss height
boss_hole_d = 11.47;      // screw clearance through the boss
boss_r = 74.35;           // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-77, 13], [-67.375, 12.147], [-57.75, 11.407], [-48.125, 10.782], [-38.5, 10.27], [-28.875, 9.872], [-19.25, 9.588], [-9.625, 9.417], [0, 9.36], [9.625, 9.417], [19.25, 9.588], [28.875, 9.872], [38.5, 10.27], [48.125, 10.782], [57.75, 11.407], [67.375, 12.147], [77, 13], [83.5, 11.258], [88.258, 6.5], [90, 0], [88.258, -6.5], [83.5, -11.258], [77, -13], [77, -13], [67.375, -12.147], [57.75, -11.407], [48.125, -10.782], [38.5, -10.27], [28.875, -9.872], [19.25, -9.588], [9.625, -9.417], [0, -9.36], [-9.625, -9.417], [-19.25, -9.588], [-28.875, -9.872], [-38.5, -10.27], [-48.125, -10.782], [-57.75, -11.407], [-67.375, -12.147], [-77, -13], [-83.5, -11.258], [-88.258, -6.5], [-90, 0], [-88.258, 6.5], [-83.5, 11.258], [-77, 13]];

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
