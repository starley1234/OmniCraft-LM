$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: plain_grooves, bore R3
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 3;               // bore radius
outer_r = 8;              // outer radius of the body
total_h = 24;             // overall height, Z
wall = 5;                 // radial wall thickness
groove_w = 2.5;           // groove width
groove_d = 3.1;           // groove depth
grooves = 2;              // number of outer grooves

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[3, 0], [8, 0], [8, 6.75], [4.9, 6.75], [4.9, 9.25], [8, 9.25], [8, 14.75], [4.9, 14.75], [4.9, 17.25], [8, 17.25], [8, 24], [3, 24]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
