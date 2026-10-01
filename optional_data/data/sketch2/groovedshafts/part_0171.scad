$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: stepped, bore R3
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 3;               // bore radius
outer_r = 6;              // outer radius of the body
total_h = 30;             // overall height, Z
wall = 3;                 // radial wall thickness
groove_w = 2.5;           // groove width
groove_d = 1.1;           // groove depth
grooves = 1;              // number of outer grooves

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[3, 0], [6, 0], [6, 13.75], [4.9, 13.75], [4.9, 16.25], [6, 16.25], [6, 30], [3, 30]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
