$fn = 32;

// ----------------------------------------------------------------------
// Handle: 150 x 42 mm grip, 14 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 150;             // grip length
width = 42;               // grip width
thickness = 14;           // grip thickness
waist = 0.86;             // width factor at the middle
draft = 0.97;             // top face scale of the extrusion
scallops = 5;             // finger rests per side
ripple = 0.05;            // depth factor of the finger rests
boss_d = 30;              // mounting boss diameter
boss_h = 6;               // mounting boss height
boss_hole_d = 12;         // screw clearance through the boss
boss_r = 58;              // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-54, 21], [-47.25, 20.402], [-40.5, 20.019], [-33.75, 18.668], [-27, 18.795], [-20.25, 19.207], [-13.5, 17.639], [-6.75, 17.765], [0, 18.963], [6.75, 17.765], [13.5, 17.639], [20.25, 19.207], [27, 18.795], [33.75, 18.668], [40.5, 20.019], [47.25, 20.402], [54, 21], [64.5, 18.187], [72.187, 10.5], [75, 0], [72.187, -10.5], [64.5, -18.187], [54, -21], [54, -21], [47.25, -20.402], [40.5, -20.019], [33.75, -18.668], [27, -18.795], [20.25, -19.207], [13.5, -17.639], [6.75, -17.765], [0, -18.963], [-6.75, -17.765], [-13.5, -17.639], [-20.25, -19.207], [-27, -18.795], [-33.75, -18.668], [-40.5, -20.019], [-47.25, -20.402], [-54, -21], [-64.5, -18.187], [-72.187, -10.5], [-75, 0], [-72.187, 10.5], [-64.5, 18.187], [-54, 21]];

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
