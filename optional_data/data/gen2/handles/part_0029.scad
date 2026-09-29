$fn = 32;

// ----------------------------------------------------------------------
// Handle: 150 x 36 mm grip, 16 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 150;             // grip length
width = 36;               // grip width
thickness = 16;           // grip thickness
waist = 0.86;             // width factor at the middle
draft = 0.9;              // top face scale of the extrusion
scallops = 4;             // finger rests per side
ripple = 0.05;            // depth factor of the finger rests
boss_d = 30;              // mounting boss diameter
boss_h = 6;               // mounting boss height
boss_hole_d = 12;         // screw clearance through the boss
boss_r = 58;              // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-57, 18], [-49.875, 17.409], [-42.75, 16.528], [-35.625, 16.464], [-28.5, 16.714], [-21.375, 15.834], [-14.25, 14.904], [-7.125, 15.519], [0, 16.254], [7.125, 15.519], [14.25, 14.904], [21.375, 15.834], [28.5, 16.714], [35.625, 16.464], [42.75, 16.528], [49.875, 17.409], [57, 18], [66, 15.588], [72.588, 9], [75, 0], [72.588, -9], [66, -15.588], [57, -18], [57, -18], [49.875, -17.409], [42.75, -16.528], [35.625, -16.464], [28.5, -16.714], [21.375, -15.834], [14.25, -14.904], [7.125, -15.519], [0, -16.254], [-7.125, -15.519], [-14.25, -14.904], [-21.375, -15.834], [-28.5, -16.714], [-35.625, -16.464], [-42.75, -16.528], [-49.875, -17.409], [-57, -18], [-66, -15.588], [-72.588, -9], [-75, 0], [-72.588, 9], [-66, 15.588], [-57, 18]];

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
