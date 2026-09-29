$fn = 32;

// ----------------------------------------------------------------------
// Handle: 60 x 30 mm grip, 20 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 60;              // grip length
width = 30;               // grip width
thickness = 20;           // grip thickness
waist = 0.86;             // width factor at the middle
draft = 0.94;             // top face scale of the extrusion
boss_d = 30;              // mounting boss diameter
boss_h = 8;               // mounting boss height
boss_hole_d = 12;         // screw clearance through the boss
boss_r = 13;              // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-15, 15], [-13.125, 14.508], [-11.25, 14.081], [-9.375, 13.72], [-7.5, 13.425], [-5.625, 13.195], [-3.75, 13.031], [-1.875, 12.933], [0, 12.9], [1.875, 12.933], [3.75, 13.031], [5.625, 13.195], [7.5, 13.425], [9.375, 13.72], [11.25, 14.081], [13.125, 14.508], [15, 15], [22.5, 12.99], [27.99, 7.5], [30, 0], [27.99, -7.5], [22.5, -12.99], [15, -15], [15, -15], [13.125, -14.508], [11.25, -14.081], [9.375, -13.72], [7.5, -13.425], [5.625, -13.195], [3.75, -13.031], [1.875, -12.933], [0, -12.9], [-1.875, -12.933], [-3.75, -13.031], [-5.625, -13.195], [-7.5, -13.425], [-9.375, -13.72], [-11.25, -14.081], [-13.125, -14.508], [-15, -15], [-22.5, -12.99], [-27.99, -7.5], [-30, 0], [-27.99, 7.5], [-22.5, 12.99], [-15, 15]];

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
