$fn = 32;

// ----------------------------------------------------------------------
// Grooved revolve: flanged, bore R8
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 8;               // bore radius
outer_r = 10.5;           // outer radius of the body
total_h = 36;             // overall height, Z
wall = 2.5;               // radial wall thickness
groove_w = 2.5;           // groove width
groove_d = 1.1;           // groove depth
grooves = 1;              // number of outer grooves
flange_r = 15.5;          // flange radius
flange_h = 6;             // flange height

bbox_x = 2 * flange_r;  // full diameter
bore_d = 2 * bore_r;  // bore diameter
body_d = 2 * outer_r;  // body diameter
flange_d = 2 * flange_r;  // flange diameter
revolve_angle = 360;  // full turn around the Z axis

profile = [[8, 0], [10.5, 0], [15.5, 0], [15.5, 6], [10.5, 6], [10.5, 19.75], [9.4, 19.75], [9.4, 22.25], [10.5, 22.25], [10.5, 36], [8, 36]];  // primary outline, 11 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
