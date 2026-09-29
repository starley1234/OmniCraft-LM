$fn = 32;

// ----------------------------------------------------------------------
// Handle: 180 x 30 mm grip, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 180;             // grip length
width = 30;               // grip width
thickness = 12;           // grip thickness
waist = 0.86;             // width factor at the middle
draft = 0.94;             // top face scale of the extrusion
scallops = 4;             // finger rests per side
ripple = 0.06;            // depth factor of the finger rests
boss_d = 30;              // mounting boss diameter
boss_h = 8;               // mounting boss height
boss_hole_d = 12;         // screw clearance through the boss
boss_r = 73;              // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-75, 15], [-65.625, 14.508], [-56.25, 13.712], [-46.875, 13.72], [-37.5, 14.029], [-28.125, 13.195], [-18.75, 12.298], [-9.375, 12.933], [0, 13.674], [9.375, 12.933], [18.75, 12.298], [28.125, 13.195], [37.5, 14.029], [46.875, 13.72], [56.25, 13.712], [65.625, 14.508], [75, 15], [82.5, 12.99], [87.99, 7.5], [90, 0], [87.99, -7.5], [82.5, -12.99], [75, -15], [75, -15], [65.625, -14.508], [56.25, -13.712], [46.875, -13.72], [37.5, -14.029], [28.125, -13.195], [18.75, -12.298], [9.375, -12.933], [0, -13.674], [-9.375, -12.933], [-18.75, -12.298], [-28.125, -13.195], [-37.5, -14.029], [-46.875, -13.72], [-56.25, -13.712], [-65.625, -14.508], [-75, -15], [-82.5, -12.99], [-87.99, -7.5], [-90, 0], [-87.99, 7.5], [-82.5, 12.99], [-75, 15]];

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
