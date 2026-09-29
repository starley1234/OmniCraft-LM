$fn = 32;

// ----------------------------------------------------------------------
// Handle: 100 x 30 mm grip, 20 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 100;             // grip length
width = 30;               // grip width
thickness = 20;           // grip thickness
waist = 0.8;              // width factor at the middle
draft = 0.97;             // top face scale of the extrusion
boss_d = 30;              // mounting boss diameter
boss_h = 6;               // mounting boss height
boss_hole_d = 12;         // screw clearance through the boss
boss_r = 33;              // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-35, 15], [-30.625, 14.297], [-26.25, 13.688], [-21.875, 13.172], [-17.5, 12.75], [-13.125, 12.422], [-8.75, 12.188], [-4.375, 12.047], [0, 12], [4.375, 12.047], [8.75, 12.188], [13.125, 12.422], [17.5, 12.75], [21.875, 13.172], [26.25, 13.688], [30.625, 14.297], [35, 15], [42.5, 12.99], [47.99, 7.5], [50, 0], [47.99, -7.5], [42.5, -12.99], [35, -15], [35, -15], [30.625, -14.297], [26.25, -13.688], [21.875, -13.172], [17.5, -12.75], [13.125, -12.422], [8.75, -12.188], [4.375, -12.047], [0, -12], [-4.375, -12.047], [-8.75, -12.188], [-13.125, -12.422], [-17.5, -12.75], [-21.875, -13.172], [-26.25, -13.688], [-30.625, -14.297], [-35, -15], [-42.5, -12.99], [-47.99, -7.5], [-50, 0], [-47.99, 7.5], [-42.5, 12.99], [-35, 15]];

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
