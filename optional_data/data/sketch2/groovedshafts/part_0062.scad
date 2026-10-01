$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: flanged, bore R3
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 3;               // bore radius
outer_r = 8;              // outer radius of the body
total_h = 44;             // overall height, Z
wall = 5;                 // radial wall thickness
groove_w = 2.5;           // groove width
groove_d = 1.9;           // groove depth
grooves = 1;              // number of outer grooves
flange_r = 16;            // flange radius
flange_h = 5;             // flange height

bbox_x = 2 * flange_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
flange_d = 2 * flange_r;  // flange diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[3, 0], [8, 0], [16, 0], [16, 5], [8, 5], [8, 23.25], [6.1, 23.25], [6.1, 25.75], [8, 25.75], [8, 44], [3, 44]];  // primary outline, 11 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
