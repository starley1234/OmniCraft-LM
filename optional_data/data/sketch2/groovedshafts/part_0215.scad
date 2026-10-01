$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: flanged, bore R3
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 3;               // bore radius
outer_r = 8;              // outer radius of the body
total_h = 30;             // overall height, Z
wall = 5;                 // radial wall thickness
groove_w = 2.5;           // groove width
groove_d = 1.9;           // groove depth
grooves = 1;              // number of outer grooves
flange_r = 13;            // flange radius
flange_h = 4;             // flange height

bbox_x = 2 * flange_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
flange_d = 2 * flange_r;  // flange diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[3, 0], [8, 0], [13, 0], [13, 4], [8, 4], [8, 15.75], [6.1, 15.75], [6.1, 18.25], [8, 18.25], [8, 30], [3, 30]];  // primary outline, 11 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
