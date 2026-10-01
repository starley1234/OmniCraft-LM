$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: thread_relief, bore R8
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 8;               // bore radius
outer_r = 10.5;           // outer radius of the body
total_h = 36;             // overall height, Z
wall = 2.5;               // radial wall thickness
groove_w = 4;             // groove width
groove_d = 1.1;           // groove depth
grooves = 1;              // number of outer grooves
relief = 2;               // thread relief leg at the bore mouth
relief_angle = 45;        // thread relief chamfer angle, degrees

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[8, 0], [10.5, 0], [10.5, 16], [9.4, 16], [9.4, 20], [10.5, 20], [10.5, 36], [10, 36], [8, 34]];  // primary outline, 9 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
