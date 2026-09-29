$fn = 32;

// ----------------------------------------------------------------------
// Handle: 180 x 42 mm grip, 14 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 180;             // grip length
width = 42;               // grip width
thickness = 14;           // grip thickness
waist = 0.8;              // width factor at the middle
draft = 0.94;             // top face scale of the extrusion
boss_d = 30;              // mounting boss diameter
boss_h = 10;              // mounting boss height
boss_hole_d = 12;         // screw clearance through the boss
boss_r = 73;              // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-69, 21], [-60.375, 20.016], [-51.75, 19.162], [-43.125, 18.441], [-34.5, 17.85], [-25.875, 17.391], [-17.25, 17.062], [-8.625, 16.866], [0, 16.8], [8.625, 16.866], [17.25, 17.062], [25.875, 17.391], [34.5, 17.85], [43.125, 18.441], [51.75, 19.162], [60.375, 20.016], [69, 21], [79.5, 18.187], [87.187, 10.5], [90, 0], [87.187, -10.5], [79.5, -18.187], [69, -21], [69, -21], [60.375, -20.016], [51.75, -19.162], [43.125, -18.441], [34.5, -17.85], [25.875, -17.391], [17.25, -17.062], [8.625, -16.866], [0, -16.8], [-8.625, -16.866], [-17.25, -17.062], [-25.875, -17.391], [-34.5, -17.85], [-43.125, -18.441], [-51.75, -19.162], [-60.375, -20.016], [-69, -21], [-79.5, -18.187], [-87.187, -10.5], [-90, 0], [-87.187, 10.5], [-79.5, 18.187], [-69, 21]];

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
