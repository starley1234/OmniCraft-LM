$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: stepped, bore R4
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 4;               // bore radius
outer_r = 9;              // outer radius of the body
total_h = 24;             // overall height, Z
wall = 5;                 // radial wall thickness
groove_w = 4;             // groove width
groove_d = 1.4;           // groove depth
grooves = 2;              // number of outer grooves

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[4, 0], [9, 0], [9, 6], [7.6, 6], [7.6, 10], [9, 10], [9, 14], [7.6, 14], [7.6, 18], [9, 18], [9, 24], [4, 24]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
