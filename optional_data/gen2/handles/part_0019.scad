$fn = 32;

// ----------------------------------------------------------------------
// Handle: 120 x 36 mm grip, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 120;             // grip length
width = 36;               // grip width
thickness = 12;           // grip thickness
waist = 0.8;              // width factor at the middle
draft = 0.9;              // top face scale of the extrusion
scallops = 5;             // finger rests per side
ripple = 0.05;            // depth factor of the finger rests
boss_d = 30;              // mounting boss diameter
boss_h = 8;               // mounting boss height
boss_hole_d = 12;         // screw clearance through the boss
boss_r = 43;              // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-42, 18], [-36.75, 17.233], [-31.5, 16.679], [-26.25, 15.361], [-21, 15.3], [-15.75, 15.498], [-10.5, 14.14], [-5.25, 14.184], [0, 15.12], [5.25, 14.184], [10.5, 14.14], [15.75, 15.498], [21, 15.3], [26.25, 15.361], [31.5, 16.679], [36.75, 17.233], [42, 18], [51, 15.588], [57.588, 9], [60, 0], [57.588, -9], [51, -15.588], [42, -18], [42, -18], [36.75, -17.233], [31.5, -16.679], [26.25, -15.361], [21, -15.3], [15.75, -15.498], [10.5, -14.14], [5.25, -14.184], [0, -15.12], [-5.25, -14.184], [-10.5, -14.14], [-15.75, -15.498], [-21, -15.3], [-26.25, -15.361], [-31.5, -16.679], [-36.75, -17.233], [-42, -18], [-51, -15.588], [-57.588, -9], [-60, 0], [-57.588, 9], [-51, 15.588], [-42, 18]];

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
