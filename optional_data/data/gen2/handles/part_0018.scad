$fn = 32;

// ----------------------------------------------------------------------
// Handle: 150 x 26 mm grip, 20 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 150;             // grip length
width = 26;               // grip width
thickness = 20;           // grip thickness
waist = 0.8;              // width factor at the middle
draft = 0.9;              // top face scale of the extrusion
scallops = 4;             // finger rests per side
ripple = 0.04;            // depth factor of the finger rests
boss_d = 27.3;            // mounting boss diameter
boss_h = 10;              // mounting boss height
boss_hole_d = 11.47;      // screw clearance through the boss
boss_r = 59.35;           // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-62, 13], [-54.25, 12.391], [-46.5, 11.655], [-38.75, 11.416], [-31, 11.382], [-23.25, 10.766], [-15.5, 10.166], [-7.75, 10.441], [0, 10.816], [7.75, 10.441], [15.5, 10.166], [23.25, 10.766], [31, 11.382], [38.75, 11.416], [46.5, 11.655], [54.25, 12.391], [62, 13], [68.5, 11.258], [73.258, 6.5], [75, 0], [73.258, -6.5], [68.5, -11.258], [62, -13], [62, -13], [54.25, -12.391], [46.5, -11.655], [38.75, -11.416], [31, -11.382], [23.25, -10.766], [15.5, -10.166], [7.75, -10.441], [0, -10.816], [-7.75, -10.441], [-15.5, -10.166], [-23.25, -10.766], [-31, -11.382], [-38.75, -11.416], [-46.5, -11.655], [-54.25, -12.391], [-62, -13], [-68.5, -11.258], [-73.258, -6.5], [-75, 0], [-73.258, 6.5], [-68.5, 11.258], [-62, 13]];

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
