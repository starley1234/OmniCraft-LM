$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: stepped, bore R5
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 5;               // bore radius
outer_r = 9;              // outer radius of the body
total_h = 24;             // overall height, Z
wall = 4;                 // radial wall thickness
groove_w = 3;             // groove width
groove_d = 1.8;           // groove depth
grooves = 1;              // number of outer grooves

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[5, 0], [9, 0], [9, 10.5], [7.2, 10.5], [7.2, 13.5], [9, 13.5], [9, 24], [5, 24]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
