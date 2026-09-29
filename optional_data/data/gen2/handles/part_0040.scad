$fn = 32;

// ----------------------------------------------------------------------
// Handle: 120 x 42 mm grip, 16 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 120;             // grip length
width = 42;               // grip width
thickness = 16;           // grip thickness
waist = 0.8;              // width factor at the middle
draft = 0.97;             // top face scale of the extrusion
scallops = 6;             // finger rests per side
ripple = 0.06;            // depth factor of the finger rests
boss_d = 30;              // mounting boss diameter
boss_h = 8;               // mounting boss height
boss_hole_d = 12;         // screw clearance through the boss
boss_r = 43;              // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-39, 21], [-34.125, 19.817], [-29.25, 19.162], [-24.375, 18.917], [-19.5, 17.047], [-14.625, 18.025], [-9.75, 17.062], [-4.875, 16.161], [0, 17.808], [4.875, 16.161], [9.75, 17.062], [14.625, 18.025], [19.5, 17.047], [24.375, 18.917], [29.25, 19.162], [34.125, 19.817], [39, 21], [49.5, 18.187], [57.187, 10.5], [60, 0], [57.187, -10.5], [49.5, -18.187], [39, -21], [39, -21], [34.125, -19.817], [29.25, -19.162], [24.375, -18.917], [19.5, -17.047], [14.625, -18.025], [9.75, -17.062], [4.875, -16.161], [0, -17.808], [-4.875, -16.161], [-9.75, -17.062], [-14.625, -18.025], [-19.5, -17.047], [-24.375, -18.917], [-29.25, -19.162], [-34.125, -19.817], [-39, -21], [-49.5, -18.187], [-57.187, -10.5], [-60, 0], [-57.187, 10.5], [-49.5, 18.187], [-39, 21]];

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
