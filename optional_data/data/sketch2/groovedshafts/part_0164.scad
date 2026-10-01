$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: flanged, bore R4
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 4;               // bore radius
outer_r = 7;              // outer radius of the body
total_h = 36;             // overall height, Z
wall = 3;                 // radial wall thickness
groove_w = 3;             // groove width
groove_d = 1.4;           // groove depth
grooves = 1;              // number of outer grooves
flange_r = 12;            // flange radius
flange_h = 5;             // flange height

bbox_x = 2 * flange_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
flange_d = 2 * flange_r;  // flange diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[4, 0], [7, 0], [12, 0], [12, 5], [7, 5], [7, 19], [5.6, 19], [5.6, 22], [7, 22], [7, 36], [4, 36]];  // primary outline, 11 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
