$fn = 32;

// ----------------------------------------------------------------------
// Handle: 100 x 36 mm grip, 20 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
length = 100;             // grip length
width = 36;               // grip width
thickness = 20;           // grip thickness
waist = 0.8;              // width factor at the middle
draft = 0.94;             // top face scale of the extrusion
scallops = 4;             // finger rests per side
ripple = 0.06;            // depth factor of the finger rests
boss_d = 30;              // mounting boss diameter
boss_h = 6;               // mounting boss height
boss_hole_d = 12;         // screw clearance through the boss
boss_r = 33;              // boss centre from the grip centre

/* ergonomic grip outline, closed spline-like polygon in the XY plane */
grip = [[-32, 18], [-28, 17.156], [-24, 15.994], [-20, 15.806], [-16, 15.989], [-12, 14.906], [-8, 13.802], [-4, 14.456], [0, 15.264], [4, 14.456], [8, 13.802], [12, 14.906], [16, 15.989], [20, 15.806], [24, 15.994], [28, 17.156], [32, 18], [41, 15.588], [47.588, 9], [50, 0], [47.588, -9], [41, -15.588], [32, -18], [32, -18], [28, -17.156], [24, -15.994], [20, -15.806], [16, -15.989], [12, -14.906], [8, -13.802], [4, -14.456], [0, -15.264], [-4, -14.456], [-8, -13.802], [-12, -14.906], [-16, -15.989], [-20, -15.806], [-24, -15.994], [-28, -17.156], [-32, -18], [-41, -15.588], [-47.588, -9], [-50, 0], [-47.588, 9], [-41, 15.588], [-32, 18]];

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
