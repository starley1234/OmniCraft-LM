$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: flanged, bore R5
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 5;               // bore radius
outer_r = 7.5;            // outer radius of the body
total_h = 24;             // overall height, Z
wall = 2.5;               // radial wall thickness
groove_w = 3;             // groove width
groove_d = 1.2;           // groove depth
grooves = 1;              // number of outer grooves
flange_r = 13.5;          // flange radius
flange_h = 5;             // flange height

bbox_x = 2 * flange_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
flange_d = 2 * flange_r;  // flange diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[5, 0], [7.5, 0], [13.5, 0], [13.5, 5], [7.5, 5], [7.5, 13], [6.3, 13], [6.3, 16], [7.5, 16], [7.5, 24], [5, 24]];  // primary outline, 11 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
