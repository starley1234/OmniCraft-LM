$fn = 32;

// ----------------------------------------------------------------------
// Handle: 180 x 42 mm grip, 20 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 180;             // grip length
width = 42;               // grip width
thickness = 20;           // grip thickness
waist = 0.86;             // width factor at the middle
draft = 0.97;             // top face scale of the extrusion
boss_d = 30;              // mounting boss diameter
boss_h = 10;              // mounting boss height
boss_hole_d = 12;         // screw clearance through the boss
boss_r = 73;              // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-69, 21], [-60.375, 20.311], [-51.75, 19.714], [-43.125, 19.208], [-34.5, 18.795], [-25.875, 18.473], [-17.25, 18.244], [-8.625, 18.106], [0, 18.06], [8.625, 18.106], [17.25, 18.244], [25.875, 18.473], [34.5, 18.795], [43.125, 19.208], [51.75, 19.714], [60.375, 20.311], [69, 21], [79.5, 18.187], [87.187, 10.5], [90, 0], [87.187, -10.5], [79.5, -18.187], [69, -21], [69, -21], [60.375, -20.311], [51.75, -19.714], [43.125, -19.208], [34.5, -18.795], [25.875, -18.473], [17.25, -18.244], [8.625, -18.106], [0, -18.06], [-8.625, -18.106], [-17.25, -18.244], [-25.875, -18.473], [-34.5, -18.795], [-43.125, -19.208], [-51.75, -19.714], [-60.375, -20.311], [-69, -21], [-79.5, -18.187], [-87.187, -10.5], [-90, 0], [-87.187, 10.5], [-79.5, 18.187], [-69, 21]];

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
