$fn = 32;

// ----------------------------------------------------------------------
// Handle: 120 x 22 mm grip, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 120;             // grip length
width = 22;               // grip width
thickness = 10;           // grip thickness
waist = 0.86;             // width factor at the middle
draft = 0.94;             // top face scale of the extrusion
scallops = 4;             // finger rests per side
ripple = 0.05;            // depth factor of the finger rests
boss_d = 23.1;            // mounting boss diameter
boss_h = 8;               // mounting boss height
boss_hole_d = 9.7;        // screw clearance through the boss
boss_r = 46.45;           // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-49, 11], [-42.875, 10.639], [-36.75, 10.1], [-30.625, 10.062], [-24.5, 10.214], [-18.375, 9.677], [-12.25, 9.108], [-6.125, 9.484], [0, 9.933], [6.125, 9.484], [12.25, 9.108], [18.375, 9.677], [24.5, 10.214], [30.625, 10.062], [36.75, 10.1], [42.875, 10.639], [49, 11], [54.5, 9.526], [58.526, 5.5], [60, 0], [58.526, -5.5], [54.5, -9.526], [49, -11], [49, -11], [42.875, -10.639], [36.75, -10.1], [30.625, -10.062], [24.5, -10.214], [18.375, -9.677], [12.25, -9.108], [6.125, -9.484], [0, -9.933], [-6.125, -9.484], [-12.25, -9.108], [-18.375, -9.677], [-24.5, -10.214], [-30.625, -10.062], [-36.75, -10.1], [-42.875, -10.639], [-49, -11], [-54.5, -9.526], [-58.526, -5.5], [-60, 0], [-58.526, 5.5], [-54.5, 9.526], [-49, 11]];

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
