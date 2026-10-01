$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: thread_relief, bore R8
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 8;               // bore radius
outer_r = 13;             // outer radius of the body
total_h = 36;             // overall height, Z
wall = 5;                 // radial wall thickness
groove_w = 4;             // groove width
groove_d = 1.3;           // groove depth
grooves = 1;              // number of outer grooves
relief = 1.2;             // thread relief leg at the bore mouth
relief_angle = 45;        // thread relief chamfer angle, degrees
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[8, 0], [13, 0], [13, 16], [11.7, 16], [11.7, 20], [13, 20], [13, 36], [9.2, 36], [8, 34.8]];  // primary outline, 9 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
