$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: stepped, bore R4
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 4;               // bore radius
outer_r = 9;              // outer radius of the body
total_h = 30;             // overall height, Z
wall = 5;                 // radial wall thickness
groove_w = 2.5;           // groove width
groove_d = 1.9;           // groove depth
grooves = 1;              // number of outer grooves

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[4, 0], [9, 0], [9, 13.75], [7.1, 13.75], [7.1, 16.25], [9, 16.25], [9, 30], [4, 30]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
