$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: stepped, bore R5
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 5;               // bore radius
outer_r = 7.5;            // outer radius of the body
total_h = 30;             // overall height, Z
wall = 2.5;               // radial wall thickness
groove_w = 3;             // groove width
groove_d = 1;             // groove depth
grooves = 2;              // number of outer grooves
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[5, 0], [7.5, 0], [7.5, 8.5], [6.5, 8.5], [6.5, 11.5], [7.5, 11.5], [7.5, 18.5], [6.5, 18.5], [6.5, 21.5], [7.5, 21.5], [7.5, 30], [5, 30]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
