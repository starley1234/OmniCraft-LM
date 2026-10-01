$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: flanged, bore R8
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 8;               // bore radius
outer_r = 11;             // outer radius of the body
total_h = 24;             // overall height, Z
wall = 3;                 // radial wall thickness
groove_w = 2.5;           // groove width
groove_d = 1.3;           // groove depth
grooves = 1;              // number of outer grooves
flange_r = 17;            // flange radius
flange_h = 5;             // flange height

bbox_x = 2 * flange_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
flange_d = 2 * flange_r;  // flange diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[8, 0], [11, 0], [17, 0], [17, 5], [11, 5], [11, 13.25], [9.7, 13.25], [9.7, 15.75], [11, 15.75], [11, 24], [8, 24]];  // primary outline, 11 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
