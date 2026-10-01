$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: flanged, bore R6
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 6;               // bore radius
outer_r = 8.5;            // outer radius of the body
total_h = 30;             // overall height, Z
wall = 2.5;               // radial wall thickness
groove_w = 2.5;           // groove width
groove_d = 1.2;           // groove depth
grooves = 1;              // number of outer grooves
flange_r = 16.5;          // flange radius
flange_h = 6;             // flange height

bbox_x = 2 * flange_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
flange_d = 2 * flange_r;  // flange diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[6, 0], [8.5, 0], [16.5, 0], [16.5, 6], [8.5, 6], [8.5, 16.75], [7.3, 16.75], [7.3, 19.25], [8.5, 19.25], [8.5, 30], [6, 30]];  // primary outline, 11 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
