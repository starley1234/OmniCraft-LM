$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: stepped, bore R5
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 5;               // bore radius
outer_r = 9;              // outer radius of the body
total_h = 44;             // overall height, Z
wall = 4;                 // radial wall thickness
groove_w = 2.5;           // groove width
groove_d = 1.6;           // groove depth
grooves = 2;              // number of outer grooves

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[5, 0], [9, 0], [9, 13.417], [7.4, 13.417], [7.4, 15.917], [9, 15.917], [9, 28.083], [7.4, 28.083], [7.4, 30.583], [9, 30.583], [9, 44], [5, 44]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
