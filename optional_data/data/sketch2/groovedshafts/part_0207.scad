$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: flanged, bore R8
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 8;               // bore radius
outer_r = 13;             // outer radius of the body
total_h = 44;             // overall height, Z
wall = 5;                 // radial wall thickness
groove_w = 2.5;           // groove width
groove_d = 3.1;           // groove depth
grooves = 1;              // number of outer grooves
flange_r = 18;            // flange radius
flange_h = 6;             // flange height

bbox_x = 2 * flange_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
flange_d = 2 * flange_r;  // flange diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[8, 0], [13, 0], [18, 0], [18, 6], [13, 6], [13, 23.75], [9.9, 23.75], [9.9, 26.25], [13, 26.25], [13, 44], [8, 44]];  // primary outline, 11 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
