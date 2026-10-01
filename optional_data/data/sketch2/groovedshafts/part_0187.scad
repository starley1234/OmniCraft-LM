$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: plain_grooves, bore R6
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 6;               // bore radius
outer_r = 10;             // outer radius of the body
total_h = 36;             // overall height, Z
wall = 4;                 // radial wall thickness
groove_w = 4;             // groove width
groove_d = 2.5;           // groove depth
grooves = 1;              // number of outer grooves

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[6, 0], [10, 0], [10, 16], [7.5, 16], [7.5, 20], [10, 20], [10, 36], [6, 36]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
