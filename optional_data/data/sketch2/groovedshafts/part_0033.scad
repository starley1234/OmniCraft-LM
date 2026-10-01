$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: thread_relief, bore R5
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 5;               // bore radius
outer_r = 8;              // outer radius of the body
total_h = 36;             // overall height, Z
wall = 3;                 // radial wall thickness
groove_w = 3;             // groove width
groove_d = 1.4;           // groove depth
grooves = 1;              // number of outer grooves
relief = 2;               // thread relief leg at the bore mouth
relief_angle = 45;        // thread relief chamfer angle, degrees

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[5, 0], [8, 0], [8, 16.5], [6.6, 16.5], [6.6, 19.5], [8, 19.5], [8, 36], [7, 36], [5, 34]];  // primary outline, 9 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
