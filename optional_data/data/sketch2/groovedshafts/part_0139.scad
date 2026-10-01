$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: stepped, bore R8
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 8;               // bore radius
outer_r = 12;             // outer radius of the body
total_h = 44;             // overall height, Z
wall = 4;                 // radial wall thickness
groove_w = 2.5;           // groove width
groove_d = 1.1;           // groove depth
grooves = 1;              // number of outer grooves

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[8, 0], [12, 0], [12, 20.75], [10.9, 20.75], [10.9, 23.25], [12, 23.25], [12, 44], [8, 44]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
