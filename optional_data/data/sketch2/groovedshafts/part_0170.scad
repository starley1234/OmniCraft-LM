$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: plain_grooves, bore R6
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 6;               // bore radius
outer_r = 9;              // outer radius of the body
total_h = 44;             // overall height, Z
wall = 3;                 // radial wall thickness
groove_w = 3;             // groove width
groove_d = 1.5;           // groove depth
grooves = 1;              // number of outer grooves

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[6, 0], [9, 0], [9, 20.5], [7.5, 20.5], [7.5, 23.5], [9, 23.5], [9, 44], [6, 44]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
