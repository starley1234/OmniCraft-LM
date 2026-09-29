$fn = 32;

// ----------------------------------------------------------------------
// Handle: 60 x 22 mm grip, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 60;              // grip length
width = 22;               // grip width
thickness = 10;           // grip thickness
waist = 0.86;             // width factor at the middle
draft = 0.9;              // top face scale of the extrusion
scallops = 5;             // finger rests per side
ripple = 0.05;            // depth factor of the finger rests
boss_d = 23.1;            // mounting boss diameter
boss_h = 8;               // mounting boss height
boss_hole_d = 9.7;        // screw clearance through the boss
boss_r = 16.45;           // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-19, 11], [-16.625, 10.687], [-14.25, 10.486], [-11.875, 9.778], [-9.5, 9.845], [-7.125, 10.061], [-4.75, 9.24], [-2.375, 9.305], [0, 9.933], [2.375, 9.305], [4.75, 9.24], [7.125, 10.061], [9.5, 9.845], [11.875, 9.778], [14.25, 10.486], [16.625, 10.687], [19, 11], [24.5, 9.526], [28.526, 5.5], [30, 0], [28.526, -5.5], [24.5, -9.526], [19, -11], [19, -11], [16.625, -10.687], [14.25, -10.486], [11.875, -9.778], [9.5, -9.845], [7.125, -10.061], [4.75, -9.24], [2.375, -9.305], [0, -9.933], [-2.375, -9.305], [-4.75, -9.24], [-7.125, -10.061], [-9.5, -9.845], [-11.875, -9.778], [-14.25, -10.486], [-16.625, -10.687], [-19, -11], [-24.5, -9.526], [-28.526, -5.5], [-30, 0], [-28.526, 5.5], [-24.5, 9.526], [-19, 11]];

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
