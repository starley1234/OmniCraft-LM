$fn = 32;

// ----------------------------------------------------------------------
// Handle: 120 x 30 mm grip, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 120;             // grip length
width = 30;               // grip width
thickness = 10;           // grip thickness
waist = 0.8;              // width factor at the middle
draft = 0.97;             // top face scale of the extrusion
boss_d = 30;              // mounting boss diameter
boss_h = 10;              // mounting boss height
boss_hole_d = 12;         // screw clearance through the boss
boss_r = 43;              // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-45, 15], [-39.375, 14.297], [-33.75, 13.688], [-28.125, 13.172], [-22.5, 12.75], [-16.875, 12.422], [-11.25, 12.188], [-5.625, 12.047], [0, 12], [5.625, 12.047], [11.25, 12.188], [16.875, 12.422], [22.5, 12.75], [28.125, 13.172], [33.75, 13.688], [39.375, 14.297], [45, 15], [52.5, 12.99], [57.99, 7.5], [60, 0], [57.99, -7.5], [52.5, -12.99], [45, -15], [45, -15], [39.375, -14.297], [33.75, -13.688], [28.125, -13.172], [22.5, -12.75], [16.875, -12.422], [11.25, -12.188], [5.625, -12.047], [0, -12], [-5.625, -12.047], [-11.25, -12.188], [-16.875, -12.422], [-22.5, -12.75], [-28.125, -13.172], [-33.75, -13.688], [-39.375, -14.297], [-45, -15], [-52.5, -12.99], [-57.99, -7.5], [-60, 0], [-57.99, 7.5], [-52.5, 12.99], [-45, 15]];

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
