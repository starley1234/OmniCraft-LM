$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: plain_grooves, bore R4
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 4;               // bore radius
outer_r = 6.5;            // outer radius of the body
total_h = 44;             // overall height, Z
wall = 2.5;               // radial wall thickness
groove_w = 2.5;           // groove width
groove_d = 1.1;           // groove depth
grooves = 1;              // number of outer grooves
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[4, 0], [6.5, 0], [6.5, 20.75], [5.4, 20.75], [5.4, 23.25], [6.5, 23.25], [6.5, 44], [4, 44]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
