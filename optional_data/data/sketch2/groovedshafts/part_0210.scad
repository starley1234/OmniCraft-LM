$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: stepped, bore R4
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 4;               // bore radius
outer_r = 7;              // outer radius of the body
total_h = 24;             // overall height, Z
wall = 3;                 // radial wall thickness
groove_w = 3;             // groove width
groove_d = 1.1;           // groove depth
grooves = 2;              // number of outer grooves

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[4, 0], [7, 0], [7, 6.5], [5.9, 6.5], [5.9, 9.5], [7, 9.5], [7, 14.5], [5.9, 14.5], [5.9, 17.5], [7, 17.5], [7, 24], [4, 24]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
