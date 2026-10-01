$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: thread_relief, bore R8
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 8;               // bore radius
outer_r = 13;             // outer radius of the body
total_h = 44;             // overall height, Z
wall = 5;                 // radial wall thickness
groove_w = 2.5;           // groove width
groove_d = 2.5;           // groove depth
grooves = 1;              // number of outer grooves
relief = 1.5;             // thread relief leg at the bore mouth
relief_angle = 45;        // thread relief chamfer angle, degrees

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[8, 0], [13, 0], [13, 20.75], [10.5, 20.75], [10.5, 23.25], [13, 23.25], [13, 44], [9.5, 44], [8, 42.5]];  // primary outline, 9 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
