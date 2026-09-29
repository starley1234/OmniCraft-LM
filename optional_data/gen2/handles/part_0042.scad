$fn = 32;

// ----------------------------------------------------------------------
// Handle: 60 x 26 mm grip, 14 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 60;              // grip length
width = 26;               // grip width
thickness = 14;           // grip thickness
waist = 0.86;             // width factor at the middle
draft = 0.9;              // top face scale of the extrusion
scallops = 4;             // finger rests per side
ripple = 0.04;            // depth factor of the finger rests
boss_d = 27.3;            // mounting boss diameter
boss_h = 10;              // mounting boss height
boss_hole_d = 11.47;      // screw clearance through the boss
boss_r = 14.35;           // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-17, 13], [-14.875, 12.573], [-12.75, 11.99], [-10.625, 11.891], [-8.5, 11.984], [-6.375, 11.436], [-4.25, 10.87], [-2.125, 11.208], [0, 11.627], [2.125, 11.208], [4.25, 10.87], [6.375, 11.436], [8.5, 11.984], [10.625, 11.891], [12.75, 11.99], [14.875, 12.573], [17, 13], [23.5, 11.258], [28.258, 6.5], [30, 0], [28.258, -6.5], [23.5, -11.258], [17, -13], [17, -13], [14.875, -12.573], [12.75, -11.99], [10.625, -11.891], [8.5, -11.984], [6.375, -11.436], [4.25, -10.87], [2.125, -11.208], [0, -11.627], [-2.125, -11.208], [-4.25, -10.87], [-6.375, -11.436], [-8.5, -11.984], [-10.625, -11.891], [-12.75, -11.99], [-14.875, -12.573], [-17, -13], [-23.5, -11.258], [-28.258, -6.5], [-30, 0], [-28.258, 6.5], [-23.5, 11.258], [-17, 13]];

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
