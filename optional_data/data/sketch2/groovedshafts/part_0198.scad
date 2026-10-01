$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: stepped, bore R3
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 3;               // bore radius
outer_r = 8;              // outer radius of the body
total_h = 30;             // overall height, Z
wall = 5;                 // radial wall thickness
groove_w = 3;             // groove width
groove_d = 1.2;           // groove depth
grooves = 2;              // number of outer grooves

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[3, 0], [8, 0], [8, 8.5], [6.8, 8.5], [6.8, 11.5], [8, 11.5], [8, 18.5], [6.8, 18.5], [6.8, 21.5], [8, 21.5], [8, 30], [3, 30]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
