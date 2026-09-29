$fn = 32;

// ----------------------------------------------------------------------
// Handle: 100 x 26 mm grip, 12 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 100;             // grip length
width = 26;               // grip width
thickness = 12;           // grip thickness
waist = 0.8;              // width factor at the middle
draft = 0.94;             // top face scale of the extrusion
scallops = 5;             // finger rests per side
ripple = 0.06;            // depth factor of the finger rests
boss_d = 27.3;            // mounting boss diameter
boss_h = 6;               // mounting boss height
boss_hole_d = 11.47;      // screw clearance through the boss
boss_r = 34.35;           // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-37, 13], [-32.375, 12.457], [-27.75, 12.083], [-23.125, 11.03], [-18.5, 11.05], [-13.875, 11.278], [-9.25, 10.142], [-4.625, 10.205], [0, 11.024], [4.625, 10.205], [9.25, 10.142], [13.875, 11.278], [18.5, 11.05], [23.125, 11.03], [27.75, 12.083], [32.375, 12.457], [37, 13], [43.5, 11.258], [48.258, 6.5], [50, 0], [48.258, -6.5], [43.5, -11.258], [37, -13], [37, -13], [32.375, -12.457], [27.75, -12.083], [23.125, -11.03], [18.5, -11.05], [13.875, -11.278], [9.25, -10.142], [4.625, -10.205], [0, -11.024], [-4.625, -10.205], [-9.25, -10.142], [-13.875, -11.278], [-18.5, -11.05], [-23.125, -11.03], [-27.75, -12.083], [-32.375, -12.457], [-37, -13], [-43.5, -11.258], [-48.258, -6.5], [-50, 0], [-48.258, 6.5], [-43.5, 11.258], [-37, 13]];

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
