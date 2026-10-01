$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: flanged, bore R6
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 6;               // bore radius
outer_r = 9;              // outer radius of the body
total_h = 24;             // overall height, Z
wall = 3;                 // radial wall thickness
groove_w = 3;             // groove width
groove_d = 1.7;           // groove depth
grooves = 1;              // number of outer grooves
flange_r = 14;            // flange radius
flange_h = 6;             // flange height

bbox_x = 2 * flange_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
flange_d = 2 * flange_r;  // flange diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[6, 0], [9, 0], [14, 0], [14, 6], [9, 6], [9, 13.5], [7.3, 13.5], [7.3, 16.5], [9, 16.5], [9, 24], [6, 24]];  // primary outline, 11 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
