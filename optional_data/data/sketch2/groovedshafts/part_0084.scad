$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: flanged, bore R6
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 6;               // bore radius
outer_r = 10;             // outer radius of the body
total_h = 24;             // overall height, Z
wall = 4;                 // radial wall thickness
groove_w = 2.5;           // groove width
groove_d = 1.6;           // groove depth
grooves = 1;              // number of outer grooves
flange_r = 16;            // flange radius
flange_h = 4;             // flange height

bbox_x = 2 * flange_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
flange_d = 2 * flange_r;  // flange diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[6, 0], [10, 0], [16, 0], [16, 4], [10, 4], [10, 12.75], [8.4, 12.75], [8.4, 15.25], [10, 15.25], [10, 24], [6, 24]];  // primary outline, 11 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
