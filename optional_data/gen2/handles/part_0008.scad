$fn = 32;

// ----------------------------------------------------------------------
// Handle: 180 x 30 mm grip, 14 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 180;             // grip length
width = 30;               // grip width
thickness = 14;           // grip thickness
waist = 0.72;             // width factor at the middle
draft = 0.97;             // top face scale of the extrusion
boss_d = 30;              // mounting boss diameter
boss_h = 8;               // mounting boss height
boss_hole_d = 12;         // screw clearance through the boss
boss_r = 73;              // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-75, 15], [-65.625, 14.016], [-56.25, 13.162], [-46.875, 12.441], [-37.5, 11.85], [-28.125, 11.391], [-18.75, 11.062], [-9.375, 10.866], [0, 10.8], [9.375, 10.866], [18.75, 11.062], [28.125, 11.391], [37.5, 11.85], [46.875, 12.441], [56.25, 13.162], [65.625, 14.016], [75, 15], [82.5, 12.99], [87.99, 7.5], [90, 0], [87.99, -7.5], [82.5, -12.99], [75, -15], [75, -15], [65.625, -14.016], [56.25, -13.162], [46.875, -12.441], [37.5, -11.85], [28.125, -11.391], [18.75, -11.062], [9.375, -10.866], [0, -10.8], [-9.375, -10.866], [-18.75, -11.062], [-28.125, -11.391], [-37.5, -11.85], [-46.875, -12.441], [-56.25, -13.162], [-65.625, -14.016], [-75, -15], [-82.5, -12.99], [-87.99, -7.5], [-90, 0], [-87.99, 7.5], [-82.5, 12.99], [-75, 15]];

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
