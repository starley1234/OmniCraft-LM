$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: plain_grooves, bore R6
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 6;               // bore radius
outer_r = 10;             // outer radius of the body
total_h = 24;             // overall height, Z
wall = 4;                 // radial wall thickness
groove_w = 3;             // groove width
groove_d = 1.1;           // groove depth
grooves = 1;              // number of outer grooves

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[6, 0], [10, 0], [10, 10.5], [8.9, 10.5], [8.9, 13.5], [10, 13.5], [10, 24], [6, 24]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
