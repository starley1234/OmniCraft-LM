$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: flanged, bore R3
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 3;               // bore radius
outer_r = 7;              // outer radius of the body
total_h = 36;             // overall height, Z
wall = 4;                 // radial wall thickness
groove_w = 2.5;           // groove width
groove_d = 2;             // groove depth
grooves = 1;              // number of outer grooves
flange_r = 13;            // flange radius
flange_h = 6;             // flange height
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

bbox_x = 2 * flange_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
flange_d = 2 * flange_r;  // flange diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[3, 0], [7, 0], [13, 0], [13, 6], [7, 6], [7, 19.75], [5, 19.75], [5, 22.25], [7, 22.25], [7, 36], [3, 36]];  // primary outline, 11 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
