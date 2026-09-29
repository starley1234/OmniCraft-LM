$fn = 32;

// ----------------------------------------------------------------------
// Handle: 80 x 22 mm grip, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 80;              // grip length
width = 22;               // grip width
thickness = 12;           // grip thickness
waist = 0.72;             // width factor at the middle
draft = 0.9;              // top face scale of the extrusion
scallops = 5;             // finger rests per side
ripple = 0.05;            // depth factor of the finger rests
boss_d = 23.1;            // mounting boss diameter
boss_h = 10;              // mounting boss height
boss_hole_d = 9.7;        // screw clearance through the boss
boss_r = 26.45;           // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-29, 11], [-25.375, 10.324], [-21.75, 9.802], [-18.125, 8.866], [-14.5, 8.69], [-10.875, 8.685], [-7.25, 7.844], [-3.625, 7.818], [0, 8.316], [3.625, 7.818], [7.25, 7.844], [10.875, 8.685], [14.5, 8.69], [18.125, 8.866], [21.75, 9.802], [25.375, 10.324], [29, 11], [34.5, 9.526], [38.526, 5.5], [40, 0], [38.526, -5.5], [34.5, -9.526], [29, -11], [29, -11], [25.375, -10.324], [21.75, -9.802], [18.125, -8.866], [14.5, -8.69], [10.875, -8.685], [7.25, -7.844], [3.625, -7.818], [0, -8.316], [-3.625, -7.818], [-7.25, -7.844], [-10.875, -8.685], [-14.5, -8.69], [-18.125, -8.866], [-21.75, -9.802], [-25.375, -10.324], [-29, -11], [-34.5, -9.526], [-38.526, -5.5], [-40, 0], [-38.526, 5.5], [-34.5, 9.526], [-29, 11]];

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
