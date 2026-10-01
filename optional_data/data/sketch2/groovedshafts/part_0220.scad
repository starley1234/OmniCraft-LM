$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: plain_grooves, bore R8
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 8;               // bore radius
outer_r = 13;             // outer radius of the body
total_h = 44;             // overall height, Z
wall = 5;                 // radial wall thickness
groove_w = 3;             // groove width
groove_d = 3.3;           // groove depth
grooves = 2;              // number of outer grooves

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[8, 0], [13, 0], [13, 13.167], [9.7, 13.167], [9.7, 16.167], [13, 16.167], [13, 27.833], [9.7, 27.833], [9.7, 30.833], [13, 30.833], [13, 44], [8, 44]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
