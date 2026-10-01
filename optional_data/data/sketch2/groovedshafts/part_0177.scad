$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: plain_grooves, bore R6
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 6;               // bore radius
outer_r = 11;             // outer radius of the body
total_h = 24;             // overall height, Z
wall = 5;                 // radial wall thickness
groove_w = 3;             // groove width
groove_d = 2;             // groove depth
grooves = 1;              // number of outer grooves
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[6, 0], [11, 0], [11, 10.5], [9, 10.5], [9, 13.5], [11, 13.5], [11, 24], [6, 24]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
