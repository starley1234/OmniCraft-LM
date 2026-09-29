$fn = 32;

// ----------------------------------------------------------------------
// Handle: 80 x 30 mm grip, 14 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 80;              // grip length
width = 30;               // grip width
thickness = 14;           // grip thickness
waist = 0.86;             // width factor at the middle
draft = 0.97;             // top face scale of the extrusion
scallops = 5;             // finger rests per side
ripple = 0.04;            // depth factor of the finger rests
boss_d = 30;              // mounting boss diameter
boss_h = 6;               // mounting boss height
boss_hole_d = 12;         // screw clearance through the boss
boss_r = 23;              // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-25, 15], [-21.875, 14.56], [-18.75, 14.255], [-15.625, 13.411], [-12.5, 13.425], [-9.375, 13.614], [-6.25, 12.686], [-3.125, 12.738], [0, 13.416], [3.125, 12.738], [6.25, 12.686], [9.375, 13.614], [12.5, 13.425], [15.625, 13.411], [18.75, 14.255], [21.875, 14.56], [25, 15], [32.5, 12.99], [37.99, 7.5], [40, 0], [37.99, -7.5], [32.5, -12.99], [25, -15], [25, -15], [21.875, -14.56], [18.75, -14.255], [15.625, -13.411], [12.5, -13.425], [9.375, -13.614], [6.25, -12.686], [3.125, -12.738], [0, -13.416], [-3.125, -12.738], [-6.25, -12.686], [-9.375, -13.614], [-12.5, -13.425], [-15.625, -13.411], [-18.75, -14.255], [-21.875, -14.56], [-25, -15], [-32.5, -12.99], [-37.99, -7.5], [-40, 0], [-37.99, 7.5], [-32.5, 12.99], [-25, 15]];

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
