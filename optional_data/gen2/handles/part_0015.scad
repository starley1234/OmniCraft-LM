$fn = 32;

// ----------------------------------------------------------------------
// Handle: 180 x 26 mm grip, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 180;             // grip length
width = 26;               // grip width
thickness = 10;           // grip thickness
waist = 0.86;             // width factor at the middle
draft = 0.97;             // top face scale of the extrusion
boss_d = 27.3;            // mounting boss diameter
boss_h = 10;              // mounting boss height
boss_hole_d = 11.47;      // screw clearance through the boss
boss_r = 74.35;           // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-77, 13], [-67.375, 12.573], [-57.75, 12.204], [-48.125, 11.891], [-38.5, 11.635], [-28.875, 11.436], [-19.25, 11.294], [-9.625, 11.208], [0, 11.18], [9.625, 11.208], [19.25, 11.294], [28.875, 11.436], [38.5, 11.635], [48.125, 11.891], [57.75, 12.204], [67.375, 12.573], [77, 13], [83.5, 11.258], [88.258, 6.5], [90, 0], [88.258, -6.5], [83.5, -11.258], [77, -13], [77, -13], [67.375, -12.573], [57.75, -12.204], [48.125, -11.891], [38.5, -11.635], [28.875, -11.436], [19.25, -11.294], [9.625, -11.208], [0, -11.18], [-9.625, -11.208], [-19.25, -11.294], [-28.875, -11.436], [-38.5, -11.635], [-48.125, -11.891], [-57.75, -12.204], [-67.375, -12.573], [-77, -13], [-83.5, -11.258], [-88.258, -6.5], [-90, 0], [-88.258, 6.5], [-83.5, 11.258], [-77, 13]];

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
