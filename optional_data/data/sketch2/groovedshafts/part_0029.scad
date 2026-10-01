$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: plain_grooves, bore R8
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 8;               // bore radius
outer_r = 12;             // outer radius of the body
total_h = 30;             // overall height, Z
wall = 4;                 // radial wall thickness
groove_w = 3;             // groove width
groove_d = 1.9;           // groove depth
grooves = 1;              // number of outer grooves
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[8, 0], [12, 0], [12, 13.5], [10.1, 13.5], [10.1, 16.5], [12, 16.5], [12, 30], [8, 30]];  // primary outline, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
