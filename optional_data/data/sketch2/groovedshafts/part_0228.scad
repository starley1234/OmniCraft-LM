$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: plain_grooves, bore R3
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 3;               // bore radius
outer_r = 8;              // outer radius of the body
total_h = 44;             // overall height, Z
wall = 5;                 // radial wall thickness
groove_w = 4;             // groove width
groove_d = 3.3;           // groove depth
grooves = 2;              // number of outer grooves

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[3, 0], [8, 0], [8, 12.667], [4.7, 12.667], [4.7, 16.667], [8, 16.667], [8, 27.333], [4.7, 27.333], [4.7, 31.333], [8, 31.333], [8, 44], [3, 44]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
