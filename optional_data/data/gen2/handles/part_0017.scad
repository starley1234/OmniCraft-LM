$fn = 32;

// ----------------------------------------------------------------------
// Handle: 80 x 42 mm grip, 14 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 80;              // grip length
width = 42;               // grip width
thickness = 14;           // grip thickness
waist = 0.8;              // width factor at the middle
draft = 0.94;             // top face scale of the extrusion
scallops = 6;             // finger rests per side
ripple = 0.04;            // depth factor of the finger rests
boss_d = 30;              // mounting boss diameter
boss_h = 6;               // mounting boss height
boss_hole_d = 12;         // screw clearance through the boss
boss_r = 23;              // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-19, 21], [-16.625, 19.883], [-14.25, 19.162], [-11.875, 18.758], [-9.5, 17.315], [-7.125, 17.813], [-4.75, 17.062], [-2.375, 16.396], [0, 17.472], [2.375, 16.396], [4.75, 17.062], [7.125, 17.813], [9.5, 17.315], [11.875, 18.758], [14.25, 19.162], [16.625, 19.883], [19, 21], [29.5, 18.187], [37.187, 10.5], [40, 0], [37.187, -10.5], [29.5, -18.187], [19, -21], [19, -21], [16.625, -19.883], [14.25, -19.162], [11.875, -18.758], [9.5, -17.315], [7.125, -17.813], [4.75, -17.062], [2.375, -16.396], [0, -17.472], [-2.375, -16.396], [-4.75, -17.062], [-7.125, -17.813], [-9.5, -17.315], [-11.875, -18.758], [-14.25, -19.162], [-16.625, -19.883], [-19, -21], [-29.5, -18.187], [-37.187, -10.5], [-40, 0], [-37.187, 10.5], [-29.5, 18.187], [-19, 21]];

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
