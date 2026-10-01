$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: thread_relief, bore R3
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 3;               // bore radius
outer_r = 5.5;            // outer radius of the body
total_h = 24;             // overall height, Z
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

profile = [[3, 0], [5.5, 0], [5.5, 10], [4.4, 10], [4.4, 14], [5.5, 14], [5.5, 24], [5, 24], [3, 22]];  // primary outline, 9 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
