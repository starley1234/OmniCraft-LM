$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: stepped, bore R4
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 4;               // bore radius
outer_r = 8;              // outer radius of the body
total_h = 44;             // overall height, Z
wall = 4;                 // radial wall thickness
groove_w = 2.5;           // groove width
groove_d = 1.9;           // groove depth
grooves = 2;              // number of outer grooves
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

bbox_x = 2 * outer_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[4, 0], [8, 0], [8, 13.417], [6.1, 13.417], [6.1, 15.917], [8, 15.917], [8, 28.083], [6.1, 28.083], [6.1, 30.583], [8, 30.583], [8, 44], [4, 44]];  // primary outline, 12 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
