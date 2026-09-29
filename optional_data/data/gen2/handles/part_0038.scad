$fn = 32;

// ----------------------------------------------------------------------
// Handle: 60 x 36 mm grip, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 60;              // grip length
width = 36;               // grip width
thickness = 10;           // grip thickness
waist = 0.72;             // width factor at the middle
draft = 0.9;              // top face scale of the extrusion
scallops = 4;             // finger rests per side
ripple = 0.06;            // depth factor of the finger rests
boss_d = 30;              // mounting boss diameter
boss_h = 10;              // mounting boss height
boss_hole_d = 12;         // screw clearance through the boss
boss_r = 13;              // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-12, 18], [-10.5, 16.819], [-9, 15.38], [-7.5, 14.929], [-6, 14.86], [-4.5, 13.669], [-3, 12.528], [-1.5, 13.039], [0, 13.738], [1.5, 13.039], [3, 12.528], [4.5, 13.669], [6, 14.86], [7.5, 14.929], [9, 15.38], [10.5, 16.819], [12, 18], [21, 15.588], [27.588, 9], [30, 0], [27.588, -9], [21, -15.588], [12, -18], [12, -18], [10.5, -16.819], [9, -15.38], [7.5, -14.929], [6, -14.86], [4.5, -13.669], [3, -12.528], [1.5, -13.039], [0, -13.738], [-1.5, -13.039], [-3, -12.528], [-4.5, -13.669], [-6, -14.86], [-7.5, -14.929], [-9, -15.38], [-10.5, -16.819], [-12, -18], [-21, -15.588], [-27.588, -9], [-30, 0], [-27.588, 9], [-21, 15.588], [-12, 18]];

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
