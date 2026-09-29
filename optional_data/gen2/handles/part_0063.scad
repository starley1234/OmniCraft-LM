$fn = 32;

// ----------------------------------------------------------------------
// Handle: 60 x 26 mm grip, 16 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 60;              // grip length
width = 26;               // grip width
thickness = 16;           // grip thickness
waist = 0.8;              // width factor at the middle
draft = 0.97;             // top face scale of the extrusion
scallops = 6;             // finger rests per side
ripple = 0.05;            // depth factor of the finger rests
boss_d = 27.3;            // mounting boss diameter
boss_h = 10;              // mounting boss height
boss_hole_d = 11.47;      // screw clearance through the boss
boss_r = 14.35;           // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-17, 13], [-14.875, 12.288], [-12.75, 11.862], [-10.625, 11.662], [-8.5, 10.636], [-6.375, 11.093], [-4.25, 10.562], [-2.125, 10.077], [0, 10.92], [2.125, 10.077], [4.25, 10.562], [6.375, 11.093], [8.5, 10.636], [10.625, 11.662], [12.75, 11.862], [14.875, 12.288], [17, 13], [23.5, 11.258], [28.258, 6.5], [30, 0], [28.258, -6.5], [23.5, -11.258], [17, -13], [17, -13], [14.875, -12.288], [12.75, -11.862], [10.625, -11.662], [8.5, -10.636], [6.375, -11.093], [4.25, -10.562], [2.125, -10.077], [0, -10.92], [-2.125, -10.077], [-4.25, -10.562], [-6.375, -11.093], [-8.5, -10.636], [-10.625, -11.662], [-12.75, -11.862], [-14.875, -12.288], [-17, -13], [-23.5, -11.258], [-28.258, -6.5], [-30, 0], [-28.258, 6.5], [-23.5, 11.258], [-17, 13]];

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
