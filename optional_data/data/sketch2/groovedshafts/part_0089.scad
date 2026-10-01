$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: flanged, bore R4
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 4;               // bore radius
outer_r = 9;              // outer radius of the body
total_h = 30;             // overall height, Z
wall = 5;                 // radial wall thickness
groove_w = 4;             // groove width
groove_d = 3.4;           // groove depth
grooves = 1;              // number of outer grooves
flange_r = 17;            // flange radius
flange_h = 5;             // flange height

bbox_x = 2 * flange_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
flange_d = 2 * flange_r;  // flange diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[4, 0], [9, 0], [17, 0], [17, 5], [9, 5], [9, 15.5], [5.6, 15.5], [5.6, 19.5], [9, 19.5], [9, 30], [4, 30]];  // primary outline, 11 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
