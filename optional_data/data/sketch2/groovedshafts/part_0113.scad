$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: thread_relief, bore R6
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 6;               // bore radius
outer_r = 11;             // outer radius of the body
total_h = 44;             // overall height, Z
wall = 5;                 // radial wall thickness
groove_w = 4;             // groove width
groove_d = 2.2;           // groove depth
grooves = 1;              // number of outer grooves
relief = 1.2;             // thread relief leg at the bore mouth
relief_angle = 45;        // thread relief chamfer angle, degrees
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[6, 0], [11, 0], [11, 20], [8.8, 20], [8.8, 24], [11, 24], [11, 44], [7.2, 44], [6, 42.8]];  // primary outline, 9 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
