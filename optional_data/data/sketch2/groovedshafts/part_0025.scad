$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: plain_grooves, bore R6
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 6;               // bore radius
outer_r = 11;             // outer radius of the body
total_h = 30;             // overall height, Z
wall = 5;                 // radial wall thickness
groove_w = 2.5;           // groove width
groove_d = 2.8;           // groove depth
grooves = 2;              // number of outer grooves

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[6, 0], [11, 0], [11, 8.75], [8.2, 8.75], [8.2, 11.25], [11, 11.25], [11, 18.75], [8.2, 18.75], [8.2, 21.25], [11, 21.25], [11, 30], [6, 30]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
