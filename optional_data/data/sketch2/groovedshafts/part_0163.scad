$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: flanged, bore R3
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 3;               // bore radius
outer_r = 6;              // outer radius of the body
total_h = 30;             // overall height, Z
wall = 3;                 // radial wall thickness
groove_w = 4;             // groove width
groove_d = 1.6;           // groove depth
grooves = 1;              // number of outer grooves
flange_r = 11;            // flange radius
flange_h = 5;             // flange height

bbox_x = 2 * flange_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
flange_d = 2 * flange_r;  // flange diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[3, 0], [6, 0], [11, 0], [11, 5], [6, 5], [6, 15.5], [4.4, 15.5], [4.4, 19.5], [6, 19.5], [6, 30], [3, 30]];  // primary outline, 11 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
