$fn = 32;

// ----------------------------------------------------------------------
// Handle: 60 x 30 mm grip, 16 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 60;              // grip length
width = 30;               // grip width
thickness = 16;           // grip thickness
waist = 0.8;              // width factor at the middle
draft = 0.94;             // top face scale of the extrusion
boss_d = 30;              // mounting boss diameter
boss_h = 8;               // mounting boss height
boss_hole_d = 12;         // screw clearance through the boss
boss_r = 13;              // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-15, 15], [-13.125, 14.297], [-11.25, 13.688], [-9.375, 13.172], [-7.5, 12.75], [-5.625, 12.422], [-3.75, 12.188], [-1.875, 12.047], [0, 12], [1.875, 12.047], [3.75, 12.188], [5.625, 12.422], [7.5, 12.75], [9.375, 13.172], [11.25, 13.688], [13.125, 14.297], [15, 15], [22.5, 12.99], [27.99, 7.5], [30, 0], [27.99, -7.5], [22.5, -12.99], [15, -15], [15, -15], [13.125, -14.297], [11.25, -13.688], [9.375, -13.172], [7.5, -12.75], [5.625, -12.422], [3.75, -12.188], [1.875, -12.047], [0, -12], [-1.875, -12.047], [-3.75, -12.188], [-5.625, -12.422], [-7.5, -12.75], [-9.375, -13.172], [-11.25, -13.688], [-13.125, -14.297], [-15, -15], [-22.5, -12.99], [-27.99, -7.5], [-30, 0], [-27.99, 7.5], [-22.5, 12.99], [-15, 15]];

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
