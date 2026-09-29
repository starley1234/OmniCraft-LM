$fn = 32;

// ----------------------------------------------------------------------
// Handle: 80 x 42 mm grip, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 80;              // grip length
width = 42;               // grip width
thickness = 10;           // grip thickness
waist = 0.72;             // width factor at the middle
draft = 0.97;             // top face scale of the extrusion
boss_d = 30;              // mounting boss diameter
boss_h = 8;               // mounting boss height
boss_hole_d = 12;         // screw clearance through the boss
boss_r = 23;              // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-19, 21], [-16.625, 19.622], [-14.25, 18.427], [-11.875, 17.417], [-9.5, 16.59], [-7.125, 15.947], [-4.75, 15.488], [-2.375, 15.212], [0, 15.12], [2.375, 15.212], [4.75, 15.488], [7.125, 15.947], [9.5, 16.59], [11.875, 17.417], [14.25, 18.427], [16.625, 19.622], [19, 21], [29.5, 18.187], [37.187, 10.5], [40, 0], [37.187, -10.5], [29.5, -18.187], [19, -21], [19, -21], [16.625, -19.622], [14.25, -18.427], [11.875, -17.417], [9.5, -16.59], [7.125, -15.947], [4.75, -15.488], [2.375, -15.212], [0, -15.12], [-2.375, -15.212], [-4.75, -15.488], [-7.125, -15.947], [-9.5, -16.59], [-11.875, -17.417], [-14.25, -18.427], [-16.625, -19.622], [-19, -21], [-29.5, -18.187], [-37.187, -10.5], [-40, 0], [-37.187, 10.5], [-29.5, 18.187], [-19, 21]];

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
