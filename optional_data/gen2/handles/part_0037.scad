$fn = 32;

// ----------------------------------------------------------------------
// Handle: 150 x 22 mm grip, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 150;             // grip length
width = 22;               // grip width
thickness = 12;           // grip thickness
waist = 0.72;             // width factor at the middle
draft = 0.97;             // top face scale of the extrusion
scallops = 6;             // finger rests per side
ripple = 0.04;            // depth factor of the finger rests
boss_d = 23.1;            // mounting boss diameter
boss_h = 6;               // mounting boss height
boss_hole_d = 9.7;        // screw clearance through the boss
boss_r = 61.45;           // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-64, 11], [-56, 10.21], [-48, 9.652], [-40, 9.28], [-32, 8.429], [-24, 8.556], [-16, 8.113], [-8, 7.746], [0, 8.237], [8, 7.746], [16, 8.113], [24, 8.556], [32, 8.429], [40, 9.28], [48, 9.652], [56, 10.21], [64, 11], [69.5, 9.526], [73.526, 5.5], [75, 0], [73.526, -5.5], [69.5, -9.526], [64, -11], [64, -11], [56, -10.21], [48, -9.652], [40, -9.28], [32, -8.429], [24, -8.556], [16, -8.113], [8, -7.746], [0, -8.237], [-8, -7.746], [-16, -8.113], [-24, -8.556], [-32, -8.429], [-40, -9.28], [-48, -9.652], [-56, -10.21], [-64, -11], [-69.5, -9.526], [-73.526, -5.5], [-75, 0], [-73.526, 5.5], [-69.5, 9.526], [-64, 11]];

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
