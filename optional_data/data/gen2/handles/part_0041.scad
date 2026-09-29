$fn = 32;

// ----------------------------------------------------------------------
// Handle: 150 x 22 mm grip, 20 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 150;             // grip length
width = 22;               // grip width
thickness = 20;           // grip thickness
waist = 0.86;             // width factor at the middle
draft = 0.9;              // top face scale of the extrusion
scallops = 5;             // finger rests per side
ripple = 0.05;            // depth factor of the finger rests
boss_d = 23.1;            // mounting boss diameter
boss_h = 10;              // mounting boss height
boss_hole_d = 9.7;        // screw clearance through the boss
boss_r = 61.45;           // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-64, 11], [-56, 10.687], [-48, 10.486], [-40, 9.778], [-32, 9.845], [-24, 10.061], [-16, 9.24], [-8, 9.305], [0, 9.933], [8, 9.305], [16, 9.24], [24, 10.061], [32, 9.845], [40, 9.778], [48, 10.486], [56, 10.687], [64, 11], [69.5, 9.526], [73.526, 5.5], [75, 0], [73.526, -5.5], [69.5, -9.526], [64, -11], [64, -11], [56, -10.687], [48, -10.486], [40, -9.778], [32, -9.845], [24, -10.061], [16, -9.24], [8, -9.305], [0, -9.933], [-8, -9.305], [-16, -9.24], [-24, -10.061], [-32, -9.845], [-40, -9.778], [-48, -10.486], [-56, -10.687], [-64, -11], [-69.5, -9.526], [-73.526, -5.5], [-75, 0], [-73.526, 5.5], [-69.5, 9.526], [-64, 11]];

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
