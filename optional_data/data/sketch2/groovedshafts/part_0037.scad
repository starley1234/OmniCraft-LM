$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: plain_grooves, bore R5
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 5;               // bore radius
outer_r = 10;             // outer radius of the body
total_h = 24;             // overall height, Z
wall = 5;                 // radial wall thickness
groove_w = 4;             // groove width
groove_d = 1.3;           // groove depth
grooves = 2;              // number of outer grooves

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[5, 0], [10, 0], [10, 6], [8.7, 6], [8.7, 10], [10, 10], [10, 14], [8.7, 14], [8.7, 18], [10, 18], [10, 24], [5, 24]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
