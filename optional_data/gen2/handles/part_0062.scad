$fn = 32;

// ----------------------------------------------------------------------
// Handle: 80 x 36 mm grip, 16 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 80;              // grip length
width = 36;               // grip width
thickness = 16;           // grip thickness
waist = 0.8;              // width factor at the middle
draft = 0.97;             // top face scale of the extrusion
scallops = 5;             // finger rests per side
ripple = 0.04;            // depth factor of the finger rests
boss_d = 30;              // mounting boss diameter
boss_h = 6;               // mounting boss height
boss_hole_d = 12;         // screw clearance through the boss
boss_r = 23;              // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-22, 18], [-19.25, 17.218], [-16.5, 16.628], [-13.75, 15.45], [-11, 15.3], [-8.25, 15.38], [-5.5, 14.237], [-2.75, 14.238], [0, 14.976], [2.75, 14.238], [5.5, 14.237], [8.25, 15.38], [11, 15.3], [13.75, 15.45], [16.5, 16.628], [19.25, 17.218], [22, 18], [31, 15.588], [37.588, 9], [40, 0], [37.588, -9], [31, -15.588], [22, -18], [22, -18], [19.25, -17.218], [16.5, -16.628], [13.75, -15.45], [11, -15.3], [8.25, -15.38], [5.5, -14.237], [2.75, -14.238], [0, -14.976], [-2.75, -14.238], [-5.5, -14.237], [-8.25, -15.38], [-11, -15.3], [-13.75, -15.45], [-16.5, -16.628], [-19.25, -17.218], [-22, -18], [-31, -15.588], [-37.588, -9], [-40, 0], [-37.588, 9], [-31, 15.588], [-22, 18]];

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
