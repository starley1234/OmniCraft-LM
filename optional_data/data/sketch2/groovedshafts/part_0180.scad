$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: thread_relief, bore R6
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 6;               // bore radius
outer_r = 10;             // outer radius of the body
total_h = 30;             // overall height, Z
wall = 4;                 // radial wall thickness
groove_w = 2.5;           // groove width
groove_d = 2.3;           // groove depth
grooves = 1;              // number of outer grooves
relief = 2;               // thread relief leg at the bore mouth
relief_angle = 45;        // thread relief chamfer angle, degrees

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[6, 0], [10, 0], [10, 13.75], [7.7, 13.75], [7.7, 16.25], [10, 16.25], [10, 30], [8, 30], [6, 28]];  // primary outline, 9 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
