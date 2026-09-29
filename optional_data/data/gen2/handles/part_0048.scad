$fn = 32;

// ----------------------------------------------------------------------
// Handle: 120 x 26 mm grip, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 120;             // grip length
width = 26;               // grip width
thickness = 12;           // grip thickness
waist = 0.8;              // width factor at the middle
draft = 0.94;             // top face scale of the extrusion
boss_d = 27.3;            // mounting boss diameter
boss_h = 6;               // mounting boss height
boss_hole_d = 11.47;      // screw clearance through the boss
boss_r = 44.35;           // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-47, 13], [-41.125, 12.391], [-35.25, 11.862], [-29.375, 11.416], [-23.5, 11.05], [-17.625, 10.766], [-11.75, 10.562], [-5.875, 10.441], [0, 10.4], [5.875, 10.441], [11.75, 10.562], [17.625, 10.766], [23.5, 11.05], [29.375, 11.416], [35.25, 11.862], [41.125, 12.391], [47, 13], [53.5, 11.258], [58.258, 6.5], [60, 0], [58.258, -6.5], [53.5, -11.258], [47, -13], [47, -13], [41.125, -12.391], [35.25, -11.862], [29.375, -11.416], [23.5, -11.05], [17.625, -10.766], [11.75, -10.562], [5.875, -10.441], [0, -10.4], [-5.875, -10.441], [-11.75, -10.562], [-17.625, -10.766], [-23.5, -11.05], [-29.375, -11.416], [-35.25, -11.862], [-41.125, -12.391], [-47, -13], [-53.5, -11.258], [-58.258, -6.5], [-60, 0], [-58.258, 6.5], [-53.5, 11.258], [-47, 13]];

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
