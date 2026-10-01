$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: flanged, bore R8
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 8;               // bore radius
outer_r = 12;             // outer radius of the body
total_h = 44;             // overall height, Z
wall = 4;                 // radial wall thickness
groove_w = 3;             // groove width
groove_d = 1.1;           // groove depth
grooves = 1;              // number of outer grooves
flange_r = 17;            // flange radius
flange_h = 5;             // flange height
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

bbox_x = 2 * flange_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
flange_d = 2 * flange_r;  // flange diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[8, 0], [12, 0], [17, 0], [17, 5], [12, 5], [12, 23], [10.9, 23], [10.9, 26], [12, 26], [12, 44], [8, 44]];  // primary outline, 11 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
