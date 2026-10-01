$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: plain_grooves, bore R8
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 8;               // bore radius
outer_r = 11;             // outer radius of the body
total_h = 36;             // overall height, Z
wall = 3;                 // radial wall thickness
groove_w = 4;             // groove width
groove_d = 1.5;           // groove depth
grooves = 2;              // number of outer grooves

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[8, 0], [11, 0], [11, 10], [9.5, 10], [9.5, 14], [11, 14], [11, 22], [9.5, 22], [9.5, 26], [11, 26], [11, 36], [8, 36]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
